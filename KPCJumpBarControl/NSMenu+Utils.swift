//
//  NSMenu+Utils.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 09/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

class MenuItem: NSMenuItem {
    override internal var image: NSImage? {
        get {
            if let obj: JumpBarItemProtocol = self.representedObject as? JumpBarItemProtocol {
                return obj.icon?.scaleToSize(NSMakeSize(KPCJumpBarItemIconMaxHeight, KPCJumpBarItemIconMaxHeight))
            }
            return nil
        }
        set {}
    }

    override internal var title: String {
        get {
            if let obj: JumpBarItemProtocol = self.representedObject as? JumpBarItemProtocol {
                return obj.title
            }
            return ""
        }
        set {}
    }
}

extension NSImage {
    
    func scaleToSize(newSize: NSSize) -> NSImage {
        
        if (self.valid) {
            if self.size.width == newSize.width && self.size.height == newSize.height {
                return self;
            }
        }
        
        let oldRect = NSMakeRect(0.0, 0.0, self.size.width, self.size.height);
        let newRect = NSMakeRect(0,0,newSize.width,newSize.height);
            
        let newImage = NSImage(size: newSize);
        newImage.lockFocus()
        self.drawInRect(newRect, fromRect:oldRect, operation:.CompositeCopy, fraction:1.0);
        newImage.unlockFocus();
        
        return newImage;
    }
}

extension NSMenu {
    
    static func menuWithSegmentsTree(segmentsTree: Array<JumpBarItemProtocol>, target: AnyObject, action: Selector) -> NSMenu {
        let menu = NSMenu()
        menu.autoenablesItems = true
        
        for (idx, segment) in segmentsTree.enumerate() {
            
            if idx == 0 {
                menu.title = segment.title
            }
        
            if segment.isSeparator {
                let item = NSMenuItem.separatorItem()
                item.representedObject = segment
                menu.addItem(item)
            }
            else {
                let item = MenuItem()
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