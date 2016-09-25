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

open class JumpBarItem: NSObject, JumpBarItemProtocol {
    open var title: String = ""
    open var icon: NSImage? = nil
    open var children: Array<JumpBarItemProtocol>? = nil
    open fileprivate(set) var isSeparator: Bool = false
    
    init(withTitle title: String, icon: NSImage?) {
        self.title = title
        self.icon = icon
        self.children = []
    }
    
    static open func item(withTitle title: String, icon: NSImage?) -> JumpBarItem {
        return JumpBarItem(withTitle: title, icon: icon)
    }
    
    static open func separatorItem() -> JumpBarItem {
        let item = JumpBarItem(withTitle: "", icon: nil)
        item.isSeparator = true
        item.children = nil
        return item
    }
}

