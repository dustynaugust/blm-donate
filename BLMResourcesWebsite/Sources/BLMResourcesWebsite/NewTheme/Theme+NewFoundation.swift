//
//  File.swift
//  
//
//  Created by Dustyn August on 6/22/20.
//

import Publish
import Plot

struct NewFoundationHTMLFactory<Site: Website>: HTMLFactory {
    /// Create the HTML to use for the website's main index page.
    /// - parameter index: The index page to generate HTML for.
    /// - parameter context: The current publishing context.
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        
        var setOfStateTags = Set<Tag>()
        let akTag = Tag("AK")
        setOfStateTags.insert(akTag)
        let alTag = Tag("AL")
        setOfStateTags.insert(alTag)
        let arTag = Tag("AR")
        setOfStateTags.insert(arTag)
        let azTag = Tag("AZ")
        setOfStateTags.insert(azTag)
        let caTag = Tag("CA")
        setOfStateTags.insert(caTag)
        let mnTag = Tag("MN")
        setOfStateTags.insert(mnTag)
        
        var setOfCityTags = Set<Tag>()
        let losAngeles = Tag("Los Angeles")
        setOfCityTags.insert(losAngeles)
        let pheonix = Tag("Pheonix")
        setOfCityTags.insert(pheonix)
        let minneapolis = Tag("Minneapolis")
        setOfCityTags.insert(minneapolis)
        let stPaulTag = Tag("St. Paul")
        setOfCityTags.insert(stPaulTag)
        
        var setOfTypeTags = Set<Tag>()
        let smallBusiness = Tag("Small Business")
        setOfTypeTags.insert(smallBusiness)
        let blackOwned = Tag("Black Owned")
        setOfTypeTags.insert(blackOwned)
        let bailFund = Tag("Bail Fund")
        setOfTypeTags.insert(bailFund)
        let mutualFund = Tag("Mutual Fund")
        setOfTypeTags.insert(mutualFund)
        
        
        
        
        return HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1("Donate by state:"),
                    .ul(
                        .class("all-tags"),
                        .forEach(context.allTags.intersection(setOfStateTags).sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .wrapper(
                    .h1("Donate by city:"),
                    .ul(
                        .class("all-tags"),
                        .forEach(context.allTags.intersection(setOfCityTags).sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .wrapper(
                    .h1("Donate by type:"),
                    .ul(
                        .class("all-tags"),
                        .forEach(context.allTags.intersection(setOfTypeTags).sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    /// Create the HTML to use for the index page of a section.
    /// - parameter section: The section to generate HTML for.
    /// - parameter context: The current publishing context.
    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .header(for: context, selectedSection: section.id),
                .wrapper(
                    .h1(.text(section.title)),
                    .itemList(for: section.items, on: context.site)
                ),
                .footer(for: context.site)
            )
        )
    }

    /// Create the HTML to use for an item.
    /// - parameter item: The item to generate HTML for.
    /// - parameter context: The current publishing context.
    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .wrapper(
                    .article(
                        .div(
                            .class("content"),
                            .contentBody(item.body)
                        ),
                        .span("Tagged with: "),
                        .tagList(for: item, on: context.site)
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    /// Create the HTML to use for a page.
    /// - parameter page: The page to generate HTML for.
    /// - parameter context: The current publishing context.
    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(.contentBody(page.body)),
                .footer(for: context.site)
            )
        )
    }

    /// Create the HTML to use for the website's list of tags, if supported.
    /// Return `nil` if the theme that this factory is for doesn't support tags.
    /// - parameter page: The tag list page to generate HTML for.
    /// - parameter context: The current publishing context.
    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        try? self.makeIndexHTML(for: context.index, context: context)
    }

    /// Create the HTML to use for a tag details page, used to represent a single
    /// tag. Return `nil` if the theme that this factory is for doesn't support tags.
    /// - parameter page: The tag details page to generate HTML for.
    /// - parameter context: The current publishing context.
    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1(
                        "Donate to: ",
                        .span(.class("tag"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Browse all donations"),
                        .href(context.index.path)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        
        return .header(
            .wrapper(
                .a(.class("site-name"), .href("/"), .text(context.site.name)),
                .if(sectionIDs.count > 1,
                    .nav(
                        .ul(.forEach(sectionIDs) { section in
                            .li(.a(
                                .class(section == selectedSection ? "selected" : ""),
                                // TODO: FIX THIS MF
                                .href(context.sections[section].path),
                                .text(context.sections[section].title)
                            ))
                        })
                    )
                )
            )
        )
    }

    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                ))
            }
        )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }

    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            ),
            .p(.a(
                .text("RSS feed"),
                .href("/feed.rss")
            ))
        )
    }
}
