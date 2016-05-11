//
//  NSIndexPath+Utils.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 09/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

extension NSIndexPath {

    func lastIndex() -> Int {
        return self.indexAtPosition(self.length-1);
    }
    
    func indexPathByAddingIndexPath(indexPath: NSIndexPath?) -> NSIndexPath {
        var path = self.copy() as! NSIndexPath
        if let ip = indexPath {
            for position in 0..<ip.length {
                path = path.indexPathByAddingIndex(ip.indexAtPosition(position))
            }
        }
        return path
    }
    
    func indexPathByAddingIndexInFront(index: Int) -> NSIndexPath {
        let indexPath = NSIndexPath(index: index)
        return indexPath.indexPathByAddingIndexPath(self)
    }
    
    func subIndexPathFromPosition(position: Int) -> NSIndexPath {
        if self.length == 0 || position > self.length-1  {
            return NSIndexPath()
        }
        return self.subIndexPathWithRange(NSMakeRange(position, self.length - position));
    }
    
    func subIndexPathToPosition(position: Int) -> NSIndexPath {
        if position < 1 || self.length == 0 {
            return NSIndexPath()
        }
        return self.subIndexPathWithRange(NSMakeRange(0, position));
    }
    
    func subIndexPathWithRange(range: NSRange) -> NSIndexPath {
        if range.location > self.length-1 || self.length == 0 || NSMaxRange(range) == 0 {
            return NSIndexPath()
        }
        
        let end = min(NSMaxRange(range), self.length); // Use length, and not length-1 because of strictly "<"end below.
        
        var path = NSIndexPath()
        for position in range.location..<end {
            path = path.indexPathByAddingIndex(self.indexAtPosition(position));
        }
        
        return path;
    }
    
    func indexPathByReplacingIndexAtPosition(position: Int, withIndex index: Int) -> NSIndexPath {
        if (self.length == 0) {
            return NSIndexPath()
        }
        else if (position == 0) {
            let trailIndexPath = self.subIndexPathFromPosition(position+1);
            return NSIndexPath(index: index).indexPathByAddingIndexPath(trailIndexPath)
        }
        else if (position == self.length-1) {
            let frontIndexPath = self.subIndexPathToPosition(position)
            return frontIndexPath.indexPathByAddingIndex(index)
        }
        else {
            let frontIndexPath = self.subIndexPathToPosition(position)
            let trailIndexPath = self.subIndexPathFromPosition(position+1)
            return frontIndexPath.indexPathByAddingIndex(index).indexPathByAddingIndexPath(trailIndexPath)
        }
    }
    
    func indexPathByReplacingLastIndexWithIndex(index: Int) -> NSIndexPath {
        return self.indexPathByReplacingIndexAtPosition(self.length-1, withIndex:index);
    }
    
    func indexPathByIncrementingLastIndex() -> NSIndexPath {
        if self.length == 0 {
            return NSIndexPath()
        }
        let lastIndex = self.indexAtPosition(self.length-1);
        return self.indexPathByReplacingIndexAtPosition(self.length-1, withIndex:lastIndex+1);
    }
    
    public func stringValue() -> String {
        let reprensentation = NSMutableString()
        reprensentation.appendFormat("%ld", self.indexAtPosition(0));
        
        for position in 1..<self.length {
            reprensentation.appendFormat(".%ld", self.indexAtPosition(position));
        }
        
        return reprensentation.copy() as! String;
    }
}
