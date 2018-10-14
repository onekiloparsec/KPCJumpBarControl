//
//  JumpBarSegment.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

// NSObjectProtocol and NSObject are necessary for JumpBarItems to be set as representedObject of NSMenuItems.

public protocol JumpBarItemProtocol: class, NSObjectProtocol {
    var title: String { get }
    var icon: NSImage? { get }
    var children: [JumpBarItemProtocol]? { get }
    var parent: JumpBarItemProtocol? { get }
    var isSeparator: Bool { get }
    //    var segmentIndexPath: IndexPath { get }
}

open class JumpBarItem: NSObject, JumpBarItemProtocol {
    open var title: String = ""
    open var icon: NSImage? = nil
    open var children: [JumpBarItemProtocol]? = nil
    open var parent: JumpBarItemProtocol? = nil
    open fileprivate(set) var isSeparator: Bool = false
    
    public init(withTitle title: String, icon: NSImage? = nil, children: [JumpBarItemProtocol]? = [], parent: JumpBarItemProtocol? = nil) {
        self.title = title
        self.icon = icon
        self.children = children
        self.parent = parent
    }
    
    static public func separatorItem() -> JumpBarItem {
        let item = JumpBarItem(withTitle: "")
        item.isSeparator = true
        item.children = nil
        return item
    }
}
