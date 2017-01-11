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
            if let obj: JumpBarItem = self.representedObject as? JumpBarItem {
                return obj.icon?.scaleToSize(NSMakeSize(KPCJumpBarItemIconMaxHeight, KPCJumpBarItemIconMaxHeight))
            }
            return nil
        }
        set {}
    }

    override internal var title: String {
        get {
            if let obj: JumpBarItem = self.representedObject as? JumpBarItem {
                return obj.title
            }
            return ""
        }
        set {}
    }
}

extension NSImage {
    
    func scaleToSize(_ newSize: NSSize) -> NSImage {
        
        if (self.isValid) {
            if self.size.width == newSize.width && self.size.height == newSize.height {
                return self
            }
        }
        
        let oldRect = NSMakeRect(0.0, 0.0, self.size.width, self.size.height)
        let newRect = NSMakeRect(0,0,newSize.width,newSize.height)
            
        let newImage = NSImage(size: newSize)
        newImage.lockFocus()
        self.draw(in: newRect, from:oldRect, operation:.copy, fraction:1.0)
        newImage.unlockFocus()
        
        return newImage
    }
}

extension NSMenu {
    
    static func menuWithSegmentsTree(_ segmentsTree: [JumpBarItem],
                                     target: AnyObject,
                                     action: Selector) -> NSMenu {
        let menu = NSMenu()
        menu.autoenablesItems = true
        
        for (idx, segment) in segmentsTree.enumerated() {
                        
            if idx == 0 {
                menu.title = segment.title
            }
        
            if segment.isSeparator {
                let item = MenuItem.separator()
                item.representedObject = segment
                menu.addItem(item)
            }
            else {
                let item = MenuItem()
                item.isEnabled = true
                item.representedObject = segment
                item.target = target
                item.action = action
                item.keyEquivalent = ""
                
                menu.addItem(item)
            
                if segment.children?.count > 0 {
                    let submenu = NSMenu.menuWithSegmentsTree(segment.children!,
                                                              target:target,
                                                              action:action)
                    menu.setSubmenu(submenu, for: item)
                }
            }
        }
        
        return menu
    }
    
    func menuItemAtIndexPath(_ indexPath: IndexPath?) -> NSMenuItem? {
        guard var ip = indexPath, ip.count > 0 else {
            return nil
        }
        
        let currentItem: NSMenuItem? = self.item(at: ip.popFirst()!)
        let menuItem: NSMenuItem? = ip.reduce(currentItem) { (result, index) -> NSMenuItem? in
            return result?.submenu?.item(at: index)
        }
        
        return menuItem        
    }
}
