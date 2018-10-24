//
//  ItemOutlineViewDelegate.swift
//  iObserve2
//
//  Created by Cédric Foellmi on 03/01/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import AppKit

typealias OutlineViewSelectionDidChangeBlock = (Notification) -> ()

class ItemOutlineViewDelegate: NSObject, NSOutlineViewDelegate {
    
    let selectionDidChangeBlock: OutlineViewSelectionDidChangeBlock
    
    init(_ block: @escaping OutlineViewSelectionDidChangeBlock) {
        self.selectionDidChangeBlock = block
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let node = (item is OutlineNode) ? item as! OutlineNode : (item as! NSTreeNode).representedObject as! OutlineNode
        var cellView: NSTableCellView? = nil
        if (node.isRoot) {
            cellView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "MainOutlineSectionCellViewIdentifier"), owner: nil) as! NSTableCellView?
        } else {
            cellView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "MainOutlineSingleLineCellViewIdentifier"), owner: nil) as! NSTableCellView?
        }
        cellView?.objectValue = node
        return cellView
    }
    
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        // Sometimes it happens, on quit???
        let node = (item is OutlineNode) ? item as! OutlineNode : (item as! NSTreeNode).representedObject as! OutlineNode
        return node.isRoot
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        let node = (item is OutlineNode) ? item as! OutlineNode : (item as! NSTreeNode).representedObject as! OutlineNode
        return !node.isRoot
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
        let node = (item is OutlineNode) ? item as! OutlineNode : (item as! NSTreeNode).representedObject as! OutlineNode
        return node.isRoot || !node.isLeaf
    }
    
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        return 24.0
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        self.selectionDidChangeBlock(notification)
    }
}
