//
//  NSMenuItem+Utils.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 09/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import AppKit

extension NSMenuItem {
    
    func indexPath() -> NSIndexPath {
        var indexPath = NSIndexPath()
        var menu = self.menu;
        var item: NSMenuItem? = self;
        
        while (menu != nil) {
            let currentIndex = menu!.indexOfItem(item!);
            indexPath = indexPath.indexPathByAddingIndexInFront(currentIndex);
            if menu!.supermenu != nil {
                let itemIndex = menu!.supermenu!.indexOfItemWithSubmenu(menu);
                menu = menu!.supermenu;
                item = menu!.itemAtIndex(itemIndex);
            }
            else {
                menu = nil
            }
        }
        
        return indexPath;
    }
}
