import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct BLMResourcesWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case filterResources = "filtered"
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://dustynaugust.github.io/blm-funds/")!
    var name = "BLM Funds"
    var description = "Donate to support BLM."
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try BLMResourcesWebsite().publish(withTheme: .newFoundation,
                                  additionalSteps: [.deploy(using: .gitHub("https://dustynaugust.github.io/blm-funds"))])
