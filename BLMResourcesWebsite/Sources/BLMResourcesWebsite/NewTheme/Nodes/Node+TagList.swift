



import Publish
import Plot


public extension Website {
    var favicon: Favicon? { .init() }
    var tagHTMLConfig: TagHTMLConfiguration? { .filterResourcesTagHTMLConfiguration }
}

public extension Path {
    static var filteredResourcesForTag: Path { "filtered" }
}

public extension Website {
    /// The path for the website's tag list page.
    var filterResourcesTagListPath: Path {
        tagHTMLConfig?.basePath ?? .filteredResourcesForTag
    }
}

public extension TagHTMLConfiguration {    
    static var filterResourcesTagHTMLConfiguration: Self {
        .init(basePath: .filteredResourcesForTag)
    }
}
