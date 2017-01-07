//
//  JumpBarSegmentControl.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

let KPCJumpBarItemControlAccessoryMenuLabelTag: NSInteger = -1
let KPCJumpBarItemControlMargin: CGFloat = 4.0
let KPCJumpBarItemIconMaxHeight: CGFloat = 16.0

protocol JumpBarSegmentControlDelegate : NSObjectProtocol {
    func jumpBarSegmentControlDidReceiveMouseDown(_ segmentControl: JumpBarSegmentControl)
}

class JumpBarSegmentControl : NSControl {
    var isLastSegment: Bool = false
    var indexInPath: Int = 0
    var isSelected: Bool = false

    var representedObject: JumpBarItemProtocol? = nil
    var delegate: JumpBarSegmentControlDelegate? = nil
    
    override func sizeToFit() {
        super.sizeToFit()

        var width: CGFloat = (2 + (self.representedObject?.icon != nil ? 1 : 0)) * KPCJumpBarItemControlMargin

        if self.representedObject?.title.characters.count > 0 {
            let textSize = self.representedObject?.title.size(withAttributes: self.attributes())
            width += ceil(textSize!.width)
        }
        if self.representedObject?.icon != nil {
            width += ceil(KPCJumpBarItemIconMaxHeight)
        }
        if (!self.isLastSegment) {
            width += 7 //Separator image
        }
        
        var frame = self.frame
        frame.size.width = width
        self.frame = frame
        
        self.setNeedsDisplay()
    }
    
    fileprivate func attributes() -> [String: AnyObject] {
        
        let highlightShadow: NSShadow = NSShadow()
        highlightShadow.shadowOffset = CGSize(width: 0, height: -1.0)
        highlightShadow.shadowColor = NSColor(calibratedWhite: 1.0, alpha: 0.5)
        highlightShadow.shadowBlurRadius = 0.0
        
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byTruncatingMiddle
        
        let color = (self.isSelected) ? NSColor(calibratedWhite:0.21, alpha:1.0) : NSColor.darkGray
        let font = (self.isSelected) ? NSFont.boldSystemFont(ofSize: 13.0) : NSFont.systemFont(ofSize: 13.0)
        
        let attributes = [NSForegroundColorAttributeName: color,
                          NSShadowAttributeName : highlightShadow,
                          NSFontAttributeName: font,
                          NSParagraphStyleAttributeName: style]
        
        return attributes
    }
    
    // MARK: Getter/Setters
    
    func minimumWidth() -> CGFloat {
        var w = KPCJumpBarItemControlMargin + (self.isLastSegment == false ? 1 : 0) * 7
        if let img = self.representedObject?.icon {
            w += img.size.width + KPCJumpBarItemControlMargin
        }
        return w
    }
    
    func select() {
        self.isSelected = true
        self.setNeedsDisplay()
    }
    
    func deselect() {
        self.isSelected = false
        self.setNeedsDisplay()
    }
    
    // MARK: Delegate
    
    override func mouseDown(with theEvent: NSEvent) {
        super.mouseDown(with: theEvent)
    
        if (self.isEnabled) {
            self.delegate?.jumpBarSegmentControlDidReceiveMouseDown(self)
        }
    }
    
    
    // MARK: Drawing
    
    override func draw(_ dirtyRect: NSRect) {
        var baseLeft: CGFloat = 0
        let fraction: CGFloat = (self.isSelected) ? 1.0 : 0.9
        let attributes = self.attributes()
        let bundle = Bundle(for: type(of: self))
        
        if (self.tag == KPCJumpBarItemControlAccessoryMenuLabelTag) {
            if let separatorImage = bundle.image(forResource: "KPCJumpBarAccessorySeparator") {
                let height = min(KPCJumpBarItemIconMaxHeight, self.frame.height - 2*KPCJumpBarItemControlMargin)
                let p: NSPoint = NSMakePoint(baseLeft + 1, self.frame.height/2.0-height/2.0)
                separatorImage.draw(at: p, from: NSZeroRect, operation: .sourceOver, fraction: fraction)
                baseLeft += separatorImage.size.width + KPCJumpBarItemControlMargin
            }
        }
        else {
            baseLeft = KPCJumpBarItemControlMargin
        }
        
        if let img = self.representedObject!.icon {
            let height = min(KPCJumpBarItemIconMaxHeight, self.frame.height - 2*KPCJumpBarItemControlMargin)
            let r = NSMakeRect(baseLeft, self.frame.height/2.0-height/2.0, height, height)
            img.draw(in: r, from:NSZeroRect, operation: .sourceOver, fraction:fraction)
            baseLeft += ceil(height) + KPCJumpBarItemControlMargin
        }
        
        if let obj = self.representedObject {
            var width = self.frame.size.width - baseLeft - KPCJumpBarItemControlMargin
            if (!self.isLastSegment && self.tag != KPCJumpBarItemControlAccessoryMenuLabelTag) {
                width -= 7.0
            }
        
            if (width > 0) {
                let height = CGFloat(20.0)
                let r = CGRect(x: baseLeft-1.0, y: (self.bounds.height-height)/2.0-1, width: width, height: height)
                obj.title.draw(in: r, withAttributes:attributes)
                baseLeft += width + KPCJumpBarItemControlMargin
            }
        }
        
        if (!self.isLastSegment && self.tag != KPCJumpBarItemControlAccessoryMenuLabelTag) {
            if let separatorImage = bundle.image(forResource: "KPCJumpBarSeparator") {
                let height = CGFloat(16.0)
                let o = NSMakePoint(baseLeft-3, self.frame.height/2.0-height/2.0)
                let r = NSMakeRect(o.x, o.y, 10.0, 16.0)
                separatorImage.draw(in: r, from:NSZeroRect, operation: .sourceOver, fraction:fraction)
            }
        }
    }
}

