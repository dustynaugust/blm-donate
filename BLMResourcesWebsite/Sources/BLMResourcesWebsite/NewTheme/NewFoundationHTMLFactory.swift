//
//  File.swift
//  
//
//  Created by Dustyn August on 6/22/20.
//

import Publish
import Plot

public extension Theme {
    static var newFoundation: Self {
        Theme(htmlFactory: NewFoundationHTMLFactory(),
              resourcePaths: ["Resources/NewFoundation/styles.css"])
    }
}
