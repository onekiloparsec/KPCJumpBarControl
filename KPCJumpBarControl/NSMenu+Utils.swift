//
//  NSMenu+Utils.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 09/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import AppKit

extension NSMenu {
    
    static func menuWithSegmentsTree(segmentsTree: Array<JumpBarItemProtocol>, target: AnyObject, action: Selector) -> NSMenu {
        let menu = NSMenu()
        menu.autoenablesItems = true
        
        for (idx, segment) in segmentsTree.enumerate() {
            
            if segment.title != nil && idx == 0 {
                menu.title = segment.title!
            }
        
            let item = NSMenuItem()
            if segment.title != nil {
                item.title = segment.title!
            }
            
            item.image = segment.icon
            item.enabled = true
            item.representedObject = segment
            item.target = target
            item.action = action
            item.keyEquivalent = ""
            
            menu.addItem(item)
            
            if segment.children?.count > 0 {
                let submenu = NSMenu.menuWithSegmentsTree(segment.children!, target:target, action:action)
                menu.setSubmenu(submenu, forItem: item)
            }
        }
        
        return menu;
    }
    
    func menuItemAtIndexPath(indexPath: NSIndexPath?) -> NSMenuItem? {
        guard let ip = indexPath else {
            return nil
        }
        
        var currentMenu: NSMenu? = self;
        let lastPosition = ip.length - 1;
        
        // Do not take last position.
        for position in 0..<lastPosition {
            var index = ip.indexAtPosition(position);
            if index >= currentMenu?.numberOfItems {
                index = 0;
            }
            let item = currentMenu?.itemAtIndex(index);
            currentMenu = item?.submenu;
        }
        
        var lastIndex = ip.indexAtPosition(lastPosition);
        if lastIndex >= currentMenu?.numberOfItems {
            lastIndex = 0;
        }
        
        if lastIndex >= currentMenu?.numberOfItems {
            print("Last menu index %ld is out of bounds in items array of menu %@", lastIndex, currentMenu);
            return nil;
        }
        
        return currentMenu?.itemAtIndex(lastIndex);
    }
}