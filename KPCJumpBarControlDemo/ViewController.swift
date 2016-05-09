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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedItemIcon?.image = nil
        self.selectedItemTitle?.stringValue = ""
        self.selectedItemIndexPath?.stringValue = ""
    
        let rootSegment = JumpBarItem.item(withTitle:"level 0", icon:NSImage(named:"Oval"))
        
        let segment1Item0 = JumpBarItem.item(withTitle:"level 1.0", icon:NSImage(named:"Polygon"))
        let segment1Item1 = JumpBarItem.item(withTitle:"level 1.1", icon:NSImage(named:"Rectangle"))
        let segment1Item2 = JumpBarItem.item(withTitle:"level 1.2", icon:NSImage(named:"Triangle"))
        
        rootSegment.children = [segment1Item0, segment1Item1, segment1Item2]
        
        let segment2Item0 = JumpBarItem.item(withTitle:"level 2.0", icon:NSImage(named:"Star"))
        let segment2Item1 = JumpBarItem.item(withTitle:"level 2.1", icon:NSImage(named:"Spiral"))
        
        segment1Item1.children = [segment2Item0, segment2Item1]
        
        self.jumpBar?.useItemsTree([rootSegment])
        self.jumpBar?.delegate = self
    }

    // MARK: - JumpBarControlDelegate

     func jumpBarControl(jumpBar: JumpBarControl, willOpenMenuAtIndexPath indexPath: NSIndexPath, withItems items: Array<JumpBarItemProtocol>) {
        print(#function)
    }

     func jumpBarControl(jumpBar: JumpBarControl, didOpenMenuAtIndexPath indexPath: NSIndexPath, withItems items: Array<JumpBarItemProtocol>) {
        print(#function)
    }

     func jumpBarControl(jumpBar: JumpBarControl, willSelectItem item: JumpBarItemProtocol, atIndexPath indexPath: NSIndexPath) {
        print(#function)
    }

     func jumpBarControl(jumpBar: JumpBarControl, didSelectItem item: JumpBarItemProtocol, atIndexPath indexPath: NSIndexPath) {
        print(#function)
        
        self.selectedItemIcon?.image = item.icon
        self.selectedItemTitle?.stringValue = item.title
        self.selectedItemIndexPath?.stringValue = "IndexPath: \(indexPath.description)"
    }
}

