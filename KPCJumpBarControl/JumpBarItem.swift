//
//  JumpBarSegment.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

// NSObjectProtocol and NSObject are necessary for JumpBarItems to be set as representedObject of NSMenuItems.

public protocol JumpBarItem: class, NSObjectProtocol {
    var title: String { get }
    var icon: NSImage? { get }
    var children: [JumpBarItem]? { get }
    var isSeparator: Bool { get }
}

