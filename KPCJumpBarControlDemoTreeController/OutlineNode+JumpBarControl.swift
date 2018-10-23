//
//  OutlineNode+JumpBarControl.swift
//  iObserve2
//
//  Created by Cédric Foellmi on 29/01/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import Foundation
import KPCJumpBarControl

extension OutlineNode: JumpBarItemProtocol {
    var parent: JumpBarItemProtocol? { get { return self.parentNode } }
    var children: [JumpBarItemProtocol]? { get { return self.childNodes as [JumpBarItemProtocol] } }
    var isSeparator: Bool { get { return false } }
}
