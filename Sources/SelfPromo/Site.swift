import Foundation
import Publish
import Plot

/// Sekcie webu. Každý podadresár v `Content/` musí mať zodpovedajúci case.
enum SelfPromoSection: String, WebsiteSectionID {
    case projects

    var title: String {
        switch self {
        case .projects: return "Projects"
        }
    }
}

/// Voliteľné metadata v YAML front matteri markdown súboru.
///
///     ---
///     date: 2024-03-01 09:00   # formát yyyy-MM-dd HH:mm, čas je povinný
///     period: 2019—
///     stack: Swift · SwiftUI
///     link: https://apps.apple.com/app/id123456789
///     ---
struct SelfPromoItemMetadata: WebsiteItemMetadata {
    /// Časové obdobie zobrazené vpravo v zozname, napr. "2019—".
    var period: String?
    /// Použité technológie, napr. "Swift · SwiftUI".
    var stack: String?
    /// Odkaz na App Store / repozitár / živý projekt.
    var link: String?
}

struct SelfPromoSite: Website {
    typealias SectionID = SelfPromoSection
    typealias ItemMetadata = SelfPromoItemMetadata

    // User site pre účet MarekSlaninka. Overené na existujúcom Pages webe
    // mapbite-support — GitHub subdoménu píše malými písmenami.
    // Repo sa musí volať MarekSlaninka.github.io, inak by web skončil
    // v podadresári a absolútne cesty nižšie by prestali fungovať.
    var url = URL(string: "https://marekslaninka.github.io")!
    var name = "Marek Slaninka"
    var description = "Lead iOS Engineer. Nine years on one healthcare product, sole technical owner of its iOS platform."
    var language: Language { .english }
    var imagePath: Path? { nil }

    // --- Obsah, ktorý nie je v markdowne ---

    /// Podnadpis pod menom v hero sekcii.
    var tagline = "Lead iOS Engineer — sole technical owner of the Surglogs iOS platform, used daily by 787+ US surgery centers."

    var links: [SocialLink] = [
        SocialLink(title: "GitHub", url: "https://github.com/MarekSlaninka"),
        SocialLink(title: "LinkedIn", url: "https://www.linkedin.com/in/marek-slaninka-47757aa5/"),
        SocialLink(title: "Email", url: "mailto:marek.slaninka@outlook.sk")
    ]
}

struct SocialLink {
    var title: String
    var url: String
}
