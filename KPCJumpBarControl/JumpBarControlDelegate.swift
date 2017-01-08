//
//  JumpBarControlDelegate.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

public protocol JumpBarControlDelegate : NSControlTextEditingDelegate {
    
    func jumpBarControl(_ jumpBar: JumpBarControl, willOpenMenuAtIndexPath indexPath:IndexPath, withItems items:[JumpBarSegmenting])
    func jumpBarControl(_ jumpBar: JumpBarControl, didOpenMenuAtIndexPath indexPath:IndexPath, withItems items:[JumpBarSegmenting])
    
    func jumpBarControl(_ jumpBar: JumpBarControl, willSelectItem item:JumpBarSegmenting, atIndexPath indexPath:IndexPath)
    func jumpBarControl(_ jumpBar: JumpBarControl, didSelectItem item:JumpBarSegmenting, atIndexPath indexPath:IndexPath)
}
