//
//  ViewController.swift
//  KPCJumpBarControlDemo
//
//  Created by Cédric Foellmi on 09/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa
import KPCJumpBarControl

class ViewController: NSViewController, JumpBarControlDelegate {

    @IBOutlet weak var jumpBar: JumpBarControl? = nil
    @IBOutlet weak var selectedItemTitle: NSTextField? = nil
    @IBOutlet weak var selectedItemIcon: NSImageView? = nil
    @IBOutlet weak var selectedItemIndexPath: NSTextField? = nil
    
    var swap: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedItemIcon?.image = nil
        self.selectedItemTitle?.stringValue = ""
        self.selectedItemIndexPath?.stringValue = ""
    
        self.jumpBar?.delegate = self
        self.swapItemsTree()
    }
    
    func swapItemsTree() {
        if swap == true {
            let rootSegment = JumpBarItem(withTitle:"path 0", icon:NSImage(named:NSImage.Name("Oval")))
            
            let segment1Item0 = JumpBarItem(withTitle:"path 0.0", icon:NSImage(named:NSImage.Name("Polygon")))
            let segment1Item1 = JumpBarItem(withTitle:"path 0.1", icon:NSImage(named:NSImage.Name("Rectangle")))
            let separatorItem = JumpBarItem.separatorItem()
            let segment1Item2 = JumpBarItem(withTitle:"path 0.3 - switch to another tree", icon:NSImage(named:NSImage.Name("Triangle")))

            rootSegment.children = [segment1Item0, segment1Item1, separatorItem, segment1Item2]

            let segment2Item0 = JumpBarItem(withTitle:"path 0.1.0", icon:NSImage(named:NSImage.Name("Star")))
            let segment2Item1 = JumpBarItem(withTitle:"path 0.1.1", icon:NSImage(named:NSImage.Name("Spiral")))

            segment1Item1.children = [segment2Item0, segment2Item1]
            
            self.jumpBar?.useItemsTree([rootSegment])
        }
        else {
            let rootSegment0 = JumpBarItem(withTitle:"path 0", icon:NSImage(named:NSImage.Name("Rectangle")))
            let rootSegment1 = JumpBarItem(withTitle:"path 1", icon:NSImage(named:NSImage.Name("Star")))

            let segment1Item0 = JumpBarItem(withTitle:"path 1.0", icon:NSImage(named:NSImage.Name("Polygon")))
            rootSegment1.children = [segment1Item0]

            let segment2Item0 = JumpBarItem(withTitle:"path 1.0.0", icon:NSImage(named:NSImage.Name("Spiral")))
            segment1Item0.children = [segment2Item0]

            let segment3Item0 = JumpBarItem(withTitle:"path 1.0.0.0 - switch to another tree", icon:NSImage(named:NSImage.Name("Triangle")))
            segment2Item0.children = [segment3Item0]

            self.jumpBar?.useItemsTree([rootSegment0, rootSegment1])
        }
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
        
        if indexPath == IndexPath(indexes: [0, 3]) || indexPath == IndexPath(indexes: [1, 0, 0, 0]) {
            swap = !swap
            self.swapItemsTree()
        }
    }
}

