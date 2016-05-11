//
//  JumpBarControlDelegate.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

public protocol JumpBarControlDelegate : NSControlTextEditingDelegate {
    
    func jumpBarControl(jumpBar: JumpBarControl, willOpenMenuAtIndexPath indexPath:NSIndexPath, withItems items:Array<JumpBarItemProtocol>)
    func jumpBarControl(jumpBar: JumpBarControl, didOpenMenuAtIndexPath indexPath:NSIndexPath, withItems items:Array<JumpBarItemProtocol>)
    
    func jumpBarControl(jumpBar: JumpBarControl, willSelectItem item:JumpBarItemProtocol, atIndexPath indexPath:NSIndexPath)
    func jumpBarControl(jumpBar: JumpBarControl, didSelectItem item:JumpBarItemProtocol, atIndexPath indexPath:NSIndexPath)
}