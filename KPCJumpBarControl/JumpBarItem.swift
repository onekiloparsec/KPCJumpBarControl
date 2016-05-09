//
//  JumpBarItem.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

public protocol JumpBarItemProtocol: NSObjectProtocol {
    var title: String? { get }
    var icon: NSImage? { get }
    var children: Array<JumpBarItemProtocol>? { get }
    var isSeparator: Bool { get }
}

public class JumpBarItem: NSObject, JumpBarItemProtocol {
    public var title: String? = nil
    public var icon: NSImage? = nil
    public var children: Array<JumpBarItemProtocol>? = nil
    public var isSeparator: Bool = false
    
    init(withTitle title: String?, icon: NSImage?) {
        self.title = title
        self.icon = icon
    }
    
    static public func item(withTitle title: String?, icon: NSImage?) -> JumpBarItem {
        return JumpBarItem(withTitle: title, icon: icon)
    }
    
    static public func separatorItem() -> JumpBarItem {
        let item = JumpBarItem(withTitle: nil, icon: nil)
        item.isSeparator = true
        return item
    }
}

