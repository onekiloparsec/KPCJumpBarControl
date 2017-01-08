//
//  JumpBarSegment.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

// NSObjectProtocol and NSObject are necessary for JumpBarItems to be set as representedObject of NSMenuItems.

public protocol JumpBarSegmenting: class, NSObjectProtocol {
    var segmentTitle: String { get }
    var segmentIcon: NSImage? { get }
    var segmentChildren: [JumpBarSegmenting]? { get }
    var segmentParent: JumpBarSegmenting? { get }
    var isSegmentSeparator: Bool { get }
//    var segmentIndexPath: IndexPath { get }
}

//extension JumpBarSegmenting {
//    public var segmentIndexPath: IndexPath {
//        get {
//            var indexPath = IndexPath()
//            var parent = self.segmentParent
//            var item: JumpBarSegmenting? = self
//        
//            while (menu != nil) {
//                let currentIndex = menu!.index(of: item!)
//                indexPath = IndexPath(index: currentIndex).appending(indexPath)
//                if menu!.supermenu != nil {
//                    let itemIndex = menu!.supermenu!.indexOfItem(withSubmenu: menu)
//                    menu = menu!.supermenu
//                    item = menu!.item(at: itemIndex)
//                }
//                else {
//                    menu = nil
//                }
//            }
//            
//            return indexPath
//        }
//    }
//}

open class JumpBarSegment: NSObject, JumpBarSegmenting {
    open var segmentTitle: String = ""
    open var segmentIcon: NSImage? = nil
    open var segmentChildren: [JumpBarSegmenting]? = nil
    open var segmentParent: JumpBarSegmenting? = nil
    open fileprivate(set) var isSegmentSeparator: Bool = false
    
    public init(withTitle title: String, icon: NSImage? = nil, children: [JumpBarSegmenting]? = [], parent: JumpBarSegmenting? = nil) {
        self.segmentTitle = title
        self.segmentIcon = icon
        self.segmentChildren = children
        self.segmentParent = parent
    }
    
    static open func separatorItem() -> JumpBarSegment {
        let item = JumpBarSegment(withTitle: "")
        item.isSegmentSeparator = true
        item.segmentChildren = nil
        return item
    }
}

