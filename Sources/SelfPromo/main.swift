import Publish

try SelfPromoSite().publish(
    withTheme: .portfolio,
    additionalSteps: [
        // Bez tohto by <title> úvodnej stránky bol "index | Marek Slaninka"
        // (Publish odvodí názov z názvu súboru) a sekcia by sa volala "Projects".
        .step(named: "Fix page titles") { context in
            context.index.title = ""
            context.sections[.projects].title = SelfPromoSection.projects.title
        }
    ]
)
