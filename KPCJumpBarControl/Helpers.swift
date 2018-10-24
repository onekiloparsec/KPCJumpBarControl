//
//  Helpers.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 25/09/2016.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

internal func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

internal func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

internal func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}

extension IndexPath {
    static func commonAncestor(indexPaths: [IndexPath]) -> IndexPath? {
        let shortestLength = indexPaths.reduce(1000) { $0 < $1.count ? $0 : $1.count }
        var common = IndexPath()
        for index in 0..<shortestLength {
            var s: Set = Set(indexPaths.map() { $0[index] })
            if s.count == 1 {
                common.append(s.popFirst()!)
            } else {
                break
            }
        }
        return common.count == 0 ? nil : common
    }
}
