//
//  JumpBarItem.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

// NSObjectProtocol and NSObject are necessary for JumpBarItems to be set as representedObject of NSMenuItems.

public protocol JumpBarItemProtocol: NSObjectProtocol {
    var title: String { get }
    var icon: NSImage? { get }
    var children: Array<JumpBarItemProtocol>? { get }
    var isSeparator: Bool { get }
}

public class JumpBarItem: NSObject, JumpBarItemProtocol {
    public var title: String = ""
    public var icon: NSImage? = nil
    public var children: Array<JumpBarItemProtocol>? = nil
    public private(set) var isSeparator: Bool = false
    
    init(withTitle title: String, icon: NSImage?) {
        self.title = title
        self.icon = icon
        self.children = []
    }
    
    static public func item(withTitle title: String, icon: NSImage?) -> JumpBarItem {
        return JumpBarItem(withTitle: title, icon: icon)
    }
    
    static public func separatorItem() -> JumpBarItem {
        let item = JumpBarItem(withTitle: "", icon: nil)
        item.isSeparator = true
        item.children = nil
        return item
    }
}

