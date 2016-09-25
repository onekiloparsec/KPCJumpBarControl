//
//  NSMenuItem+Utils.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 09/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

extension NSMenuItem {
    
    func indexPath() -> IndexPath {
        var indexPath = IndexPath()
        var menu = self.menu
        var item: NSMenuItem? = self
        
        while (menu != nil) {
            let currentIndex = menu!.index(of: item!)
            indexPath = IndexPath(index: currentIndex).appending(indexPath)
            if menu!.supermenu != nil {
                let itemIndex = menu!.supermenu!.indexOfItem(withSubmenu: menu)
                menu = menu!.supermenu
                item = menu!.item(at: itemIndex)
            }
            else {
                menu = nil
            }
        }
        
        return indexPath
    }
}
