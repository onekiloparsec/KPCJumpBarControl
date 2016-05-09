//
//  JumpBarSegmentControl.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import AppKit

let KPCJumpBarItemControlAccessoryMenuLabelTag: NSInteger = -1
let KPCJumpBarItemControlMargin: CGFloat = 4.0;
let KPCJumpBarItemIconMaxHeight: CGFloat = 16.0;

protocol JumpBarSegmentControlDelegate : NSObjectProtocol {
    func jumpBarSegmentControlDidReceiveMouseDown(segmentControl: JumpBarSegmentControl)
}

class JumpBarSegmentControl : NSControl {
    var isLastSegment: Bool = false
    var indexInLevel: Int = 0
    var isSelected: Bool = false

    var representedObject: JumpBarItemProtocol? = nil
    var delegate: JumpBarSegmentControlDelegate? = nil
    
    override func sizeToFit() {
        super.sizeToFit()
    
        if let obj = self.representedObject {
            var width: CGFloat = (2 + (obj.icon != nil ? 1 : 0)) * KPCJumpBarItemControlMargin;
            if obj.title.characters.count > 0 {
                let textSize = obj.title.sizeWithAttributes(self.attributes())
                width += ceil(textSize.width);
            }
            if let img = obj.icon {
                width += ceil(img.size.width);
            }
            if (!self.isLastSegment) {
                width += 7; //Separator image
            }
            
            var frame = self.frame;
            frame.size.width = width;
            self.frame = frame;
        }
    }
    
    private func attributes() -> [String: AnyObject] {
        
        let highlightShadow: NSShadow = NSShadow()
        highlightShadow.shadowOffset = CGSizeMake(0, -1.0)
        highlightShadow.shadowColor = NSColor(calibratedWhite: 1.0, alpha: 0.5)
        highlightShadow.shadowBlurRadius = 0.0;
        
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .ByTruncatingTail
        
        let color = (self.isSelected) ? NSColor(calibratedWhite:0.21, alpha:1.0) : NSColor.darkGrayColor();
        let font = (self.isSelected) ? NSFont.boldSystemFontOfSize(12.0) : NSFont.systemFontOfSize(12.0);
        
        let attributes = [NSForegroundColorAttributeName: color,
                          NSShadowAttributeName : highlightShadow,
                          NSFontAttributeName: font,
                          NSParagraphStyleAttributeName: style]
        
        return attributes
    }
    
    // MARK: Getter/Setters
    
    func minimumWidth() -> CGFloat {
        var w = KPCJumpBarItemControlMargin + (self.isLastSegment == false ? 1 : 0) * 7;
        if let img = self.representedObject?.icon {
            w += img.size.width + KPCJumpBarItemControlMargin;
        }
        return w
    }
    
    func select() {
        self.isSelected = true;
        self.setNeedsDisplay()
    }
    
    func deselect() {
        self.isSelected = false;
        self.setNeedsDisplay()
    }
    
    // MARK: Delegate
    
    override func mouseDown(theEvent: NSEvent) {
        super.mouseDown(theEvent)
    
        if (self.enabled) {
            self.delegate?.jumpBarSegmentControlDidReceiveMouseDown(self)
        }
    }
    
    
    // MARK: Drawing
    
    override func drawRect(dirtyRect: NSRect) {
        var baseLeft: CGFloat = 0;
        let fraction: CGFloat = (self.isSelected) ? 1.0 : 0.9;
        let attributes = self.attributes();
        let bundle = NSBundle(forClass: self.dynamicType);
        
        if (self.tag == KPCJumpBarItemControlAccessoryMenuLabelTag) {
            if let separatorImage = bundle.imageForResource("KPCJumpBarAccessorySeparator") {
                let p: NSPoint = NSMakePoint(baseLeft + 1, self.frame.size.height / 2.0 - separatorImage.size.height / 2.0)
                separatorImage.drawAtPoint(p, fromRect: NSZeroRect, operation: .CompositeSourceOver, fraction: fraction)
                baseLeft += separatorImage.size.width + KPCJumpBarItemControlMargin;
            }
        }
        else {
            baseLeft = KPCJumpBarItemControlMargin;
        }
        
        if let img = self.representedObject!.icon {
            let side = CGRectGetHeight(self.frame) - 2*KPCJumpBarItemControlMargin
            let r = NSMakeRect(baseLeft, KPCJumpBarItemControlMargin, side, side)
            img.drawInRect(r, fromRect:NSZeroRect, operation: .CompositeSourceOver, fraction:fraction);
            baseLeft += ceil(side) + KPCJumpBarItemControlMargin;
        }
        
        if let obj = self.representedObject {
            var width = self.frame.size.width - baseLeft - KPCJumpBarItemControlMargin;
            if (!self.isLastSegment && self.tag != KPCJumpBarItemControlAccessoryMenuLabelTag) {
                width -= 7.0;
            }
        
            if (width > 0) {
                let r = CGRectMake(baseLeft, 1.0, width, 20.0);
                obj.title.drawInRect(r, withAttributes:attributes);
                baseLeft += width + KPCJumpBarItemControlMargin;
            }
        }
        
        if (!self.isLastSegment && self.tag != KPCJumpBarItemControlAccessoryMenuLabelTag) {
            if let separatorImage = bundle.imageForResource("KPCJumpBarSeparator") {
                let o = NSMakePoint(baseLeft-3, 4.0);
                let r = NSMakeRect(o.x, o.y, 11, 16);
                separatorImage.drawInRect(r, fromRect:NSZeroRect, operation: .CompositeSourceOver, fraction:fraction);
            }
        }
    }
}

