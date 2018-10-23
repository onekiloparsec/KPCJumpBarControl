//
//  ItemOutlineViewDataSource.swift
//  iObserve2
//
//  Created by Cédric Foellmi on 03/01/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import AppKit

class ItemOutlineViewDataSource: NSObject, NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil { return 0 }
        let node = (item as! NSTreeNode).representedObject as! OutlineNode
        return node.outlineChildren.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
//        if item == nil { return appState.itemTreeState.nodes[index] }
        let node = (item as! NSTreeNode).representedObject as! OutlineNode
        return node.outlineChildren[index]
    }
    
    public func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return true
    }    
}
