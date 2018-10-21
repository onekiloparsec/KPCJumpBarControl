//
//  NSTreeController+Utils.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 10/01/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import AppKit

extension NSTreeController {
    func arrangedRootObjects() -> [JumpBarItemProtocol] {
        guard let rootTreeNode = self.arrangedObjects as AnyObject? else {
            return []
        }
        
        guard let proxyChildren = rootTreeNode.children as [NSTreeNode]? else {
            return []
        }
        
        return proxyChildren.map({ $0.representedObject as! JumpBarItemProtocol })
    }    
}

