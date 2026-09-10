import Foundation
import Publish
import Plot

extension Theme where Site == SelfPromoSite {
    /// Minimalistický typografický theme. Štýly sú v `Resources/css/style.css`.
    static var portfolio: Self {
        // resourcePaths tu netreba — celý priečinok Resources/ kopíruje
        // samostatný krok pipeline, inak by vznikla kópia navyše v koreni.
        Theme(htmlFactory: PortfolioHTMLFactory())
    }
}

private struct PortfolioHTMLFactory: HTMLFactory {
    typealias Site = SelfPromoSite

    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        let site = context.site
        let projects = context.sections[.projects].items
            .sorted { $0.date > $1.date }

        return HTML(
            .lang(site.language),
            .siteHead(for: index, on: site),
            .body(
                .div(
                    .class("wrap"),
                    .header(
                        .class("hero"),
                        .h1(.class("name"), .text(site.name)),
                        .p(.class("role"), .text(site.tagline))
                    ),
                    .if(!index.body.isEmpty,
                        .section(.class("prose"), index.body.node)
                    ),
                    .if(!projects.isEmpty,
                        .section(
                            .hr(.class("rule")),
                            .p(.class("lbl"), .text("Selected work")),
                            .div(.class("list"), .forEach(projects) { .projectRow($0) })
                        )
                    ),
                    .siteFooter(for: site)
                )
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        let site = context.site
        let items = section.items.sorted { $0.date > $1.date }

        return HTML(
            .lang(site.language),
            .siteHead(for: section, on: site),
            .body(
                .div(
                    .class("wrap"),
                    .backLink(to: site),
                    .h2(.class("page-title"), .text(section.id.title)),
                    .div(.class("list"), .forEach(items) { .projectRow($0) }),
                    .siteFooter(for: site)
                )
            )
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        let site = context.site

        return HTML(
            .lang(site.language),
            .siteHead(for: item, on: site),
            .body(
                .div(
                    .class("wrap"),
                    .backLink(to: site),
                    .article(
                        .class("prose"),
                        .h2(.class("page-title"), .text(item.title)),
                        .metaLine(for: item),
                        item.body.node,
                        .unwrap(item.metadata.link) { link in
                            .p(.a(.class("cta"),
                                  .href(link),
                                  .target(.blank),
                                  .rel(.noopener),
                                  .text("View project")))
                        }
                    ),
                    .siteFooter(for: site)
                )
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        let site = context.site

        return HTML(
            .lang(site.language),
            .siteHead(for: page, on: site),
            .body(
                .div(
                    .class("wrap"),
                    .backLink(to: site),
                    .article(.class("prose"), page.body.node),
                    .siteFooter(for: site)
                )
            )
        )
    }

    // Portfólio tagy nepoužíva — nil znamená, že sa stránky tagov negenerujú.
    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? { nil }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? { nil }
}

// MARK: - Hlavička dokumentu

private extension Node where Context == HTML.DocumentContext {
    static func siteHead<T: Location>(for location: T,
                                      on site: SelfPromoSite) -> Node {
        .head(
            for: location,
            on: site,
            stylesheetPaths: [
                "https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=IBM+Plex+Sans:wght@400;500&display=swap",
                "/css/style.css"
            ]
        )
    }
}

// MARK: - Znovupoužiteľné časti stránky

private extension Node where Context == HTML.BodyContext {
    static func projectRow(_ item: Item<SelfPromoSite>) -> Node {
        .div(
            .class("row"),
            .h3(.a(.href(item.path), .text(item.title))),
            .unwrap(item.metadata.period) { .span(.class("yr"), .text($0)) },
            .p(.text(item.description))
        )
    }

    static func metaLine(for item: Item<SelfPromoSite>) -> Node {
        let parts = [item.metadata.period, item.metadata.stack].compactMap { $0 }
        guard !parts.isEmpty else { return .empty }
        return .p(.class("meta"), .text(parts.joined(separator: " · ")))
    }

    static func backLink(to site: SelfPromoSite) -> Node {
        .p(.class("back"), .a(.href("/"), .text(site.name)))
    }

    static func siteFooter(for site: SelfPromoSite) -> Node {
        .footer(
            .class("foot"),
            .hr(.class("rule")),
            .nav(
                .class("links"),
                .forEach(site.links) { link in
                    .a(.href(link.url), .text(link.title))
                }
            )
        )
    }
}
