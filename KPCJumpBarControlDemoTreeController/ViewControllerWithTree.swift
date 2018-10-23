//
//  ViewController.swift
//  KPCJumpBarControlDemo
//
//  Created by Cédric Foellmi on 09/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa
import KPCJumpBarControl

class ViewControllerWithTree: NSViewController, JumpBarControlDelegate {

    @IBOutlet weak var outlineView: NSOutlineView!
    var outlineViewDataSource: ItemOutlineViewDataSource!
    var outlineViewDelegate: ItemOutlineViewDelegate!

    @IBOutlet weak var jumpBar: JumpBarControl!
    @IBOutlet weak var selectedItemTitle: NSTextField? = nil
    @IBOutlet weak var selectedItemIcon: NSImageView? = nil
    @IBOutlet weak var selectedItemIndexPath: NSTextField? = nil
    
    var treeController: NSTreeController!
    var nodes: [OutlineNode] = []
    @objc var selectedIndexPaths: [IndexPath] = []

    var swap: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        self.outlineViewDataSource = ItemOutlineViewDataSource()
        self.outlineViewDelegate = ItemOutlineViewDelegate({ (notif) in
            print("selected!")
        })
        
        self.outlineView.dataSource = self.outlineViewDataSource
        self.outlineView.delegate = self.outlineViewDelegate
        
        self.selectedItemIcon?.image = nil
        self.selectedItemTitle?.stringValue = ""
        self.selectedItemIndexPath?.stringValue = ""
    
        self.treeController = NSTreeController()
        self.treeController.childrenKeyPath = "outlineChildren" // see OutlineNode
        self.treeController.leafKeyPath = "isLeaf"
        self.treeController.avoidsEmptySelection = false
        self.treeController.preservesSelection = true
        self.treeController.selectsInsertedObjects = true
        self.treeController.alwaysUsesMultipleValuesMarker = false
        self.treeController.objectClass = OutlineNode.classForCoder()
        self.treeController.isEditable = true
        
        self.outlineView.bind(NSBindingName.content,
                              to: self.treeController,
                              withKeyPath: "arrangedObjects",
                              options: nil)
        
        self.outlineView.bind(NSBindingName.selectionIndexPaths,
                              to: self,
                              withKeyPath: "selectedIndexPaths",
                              options: nil)

        self.jumpBar.delegate = self
        
        try! self.jumpBar.bind(itemsTreeTo: self.treeController)
        
        self.treeController.addObject(OutlineNode("root1"))
        self.treeController.setSelectionIndexPath(IndexPath(index: 0))
        self.treeController.addObject(OutlineNode("first child"))
    }

    // MARK: - JumpBarControlDelegate

     func jumpBarControl(_ jumpBar: JumpBarControl, willOpenMenuAtIndexPath indexPath: IndexPath, withItems items: [JumpBarItem]) {
        print(#function)
    }

     func jumpBarControl(_ jumpBar: JumpBarControl, didOpenMenuAtIndexPath indexPath: IndexPath, withItems items: [JumpBarItem]) {
        print(#function)
    }

     func jumpBarControl(_ jumpBar: JumpBarControl, willSelectItem item: JumpBarItem, atIndexPath indexPath: IndexPath) {
        print(#function)
    }

     func jumpBarControl(_ jumpBar: JumpBarControl, didSelectItem item: JumpBarItem, atIndexPath indexPath: IndexPath) {
        print(#function)
        
        self.selectedItemIcon?.image = item.icon
        self.selectedItemTitle?.stringValue = item.title
        self.selectedItemIndexPath?.stringValue = "IndexPath: \(indexPath.description)"
    }
}

