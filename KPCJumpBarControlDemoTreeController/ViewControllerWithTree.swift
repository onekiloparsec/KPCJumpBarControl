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
    
    @IBOutlet var treeController: NSTreeController!
    @objc var nodes: [OutlineNode] = []
    @objc var selectionIndexPaths: [IndexPath] = []

    var swap: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        self.outlineViewDataSource = ItemOutlineViewDataSource()
        self.outlineViewDelegate = ItemOutlineViewDelegate({ (notification) in
            let outlineView = notification.object as! NSOutlineView
            let indexes = outlineView.selectedRowIndexes
            print("selected! \(indexes)")
//            let windowCtlr = outlineView.window!.windowController as! MainWindowController
//            self.selectedIndexPaths = [IndexPath(index: <#T##IndexPath.Element#>)]
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
        
        self.treeController.bind(NSBindingName.content,
                                 to: self,
                                 withKeyPath: "nodes",
                                 options: nil)
        
        self.treeController.bind(NSBindingName.selectionIndexPaths,
                                 to: self,
                                 withKeyPath: "selectionIndexPaths",
                                 options: nil)

        self.outlineView.bind(NSBindingName.content,
                              to: self.treeController,
                              withKeyPath: "arrangedObjects",
                              options: nil)
        
        self.outlineView.bind(NSBindingName.selectionIndexPaths,
                              to: self.treeController,
                              withKeyPath: "selectionIndexPaths",
                              options: nil)

        self.jumpBar.delegate = self
        
        try! self.jumpBar.bindItemsTree(to: self.treeController)
        
        let rootNode = OutlineNode("root1")
        rootNode.childNodes.append(OutlineNode("first child", icon: NSImage(named: NSImage.Name(rawValue: "Star"))))
        let secondChildNode = OutlineNode("second child", icon: NSImage(named: NSImage.Name(rawValue: "Polygon")))
        secondChildNode.childNodes.append(OutlineNode("down there", icon: NSImage(named: NSImage.Name(rawValue: "Rectangle"))))
        rootNode.childNodes.append(secondChildNode)
        rootNode.childNodes.append(OutlineNode("third child", icon: NSImage(named: NSImage.Name(rawValue: "Triangle"))))
        
        self.treeController.addObject(rootNode)
        let answer = self.treeController.setSelectionIndexPath(IndexPath(arrayLiteral: 0, 0))
        self.outlineView.expandItem(self.outlineView.item(atRow: 0))
        print("Selected ? \(answer)")
    }

    // MARK: - JumpBarControlDelegate

     func jumpBarControl(_ jumpBar: JumpBarControl, willOpenMenuAtIndexPath indexPath: IndexPath, withItems items: [JumpBarItemProtocol]) {
        print(#function)
    }

     func jumpBarControl(_ jumpBar: JumpBarControl, didOpenMenuAtIndexPath indexPath: IndexPath, withItems items: [JumpBarItemProtocol]) {
        print(#function)
    }

     func jumpBarControl(_ jumpBar: JumpBarControl, willSelectItems items: [JumpBarItemProtocol], atIndexPaths indexPaths: [IndexPath]) {
        print(#function)
    }

     func jumpBarControl(_ jumpBar: JumpBarControl, didSelectItems items: [JumpBarItemProtocol], atIndexPaths indexPaths: [IndexPath]) {
        print(#function)
        
        self.selectedItemIcon?.image = (items.count == 1) ? items.first!.icon : nil
        self.selectedItemTitle?.stringValue = (items.count == 1) ? items.first!.title : "(multiple selection)"
        self.selectedItemIndexPath?.stringValue = (items.count == 1) ? "IndexPath: \(indexPaths.first!.description)" : "(multiple selection)"
        
        self.treeController.setSelectionIndexPaths(indexPaths)
    }
}

