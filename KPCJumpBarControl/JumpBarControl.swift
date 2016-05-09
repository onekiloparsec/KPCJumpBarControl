//
//  JumpBarControl.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import AppKit

let KPCJumpBarControlNormalHeight: CGFloat = 23.0;
let KPCJumpBarControlNormalImageSize: CGFloat = 16.0;
let KPCJumpBarControlAccessoryMenuLabelTag: NSInteger = -1;
let KPCJumpBarControlTag: NSInteger = -9999999;

public class JumpBarControl : NSControl, JumpBarSegmentControlDelegate {
    public weak var delegate: JumpBarControlDelegate? = nil
    public private(set) var selectedIndexPath: NSIndexPath? = nil
    
    private var changeFontAndImageInMenu: Bool = false
    private var hasCompressedSegments: Bool = false
    private var isSelected: Bool = false
    
    // MARK: - Overrides
    
    override public var flipped: Bool {
        get { return true }
    }
    
    override public var enabled: Bool {
        didSet {
            for segmentControl in self.segmentControls() {
                segmentControl.enabled = super.enabled
            }
            self.setNeedsDisplay()
        }
    }
    
    override public var frame: NSRect {
        didSet {
            self.layoutSegmentsIfNeeded(withNewSize:super.frame.size)
        }
    }

    override public var bounds: NSRect {
        didSet {
            self.layoutSegmentsIfNeeded(withNewSize:super.bounds.size)
        }
    }
    
    // MARK: - Constructors

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    override public func menuForEvent(event: NSEvent) -> NSMenu? {
        return nil;
    }

    private func setup() {
        self.tag = KPCJumpBarControlTag;
        self.enabled = true;
        self.changeFontAndImageInMenu = true;
    }
    
    // MARK: - Window

    override public func viewWillMoveToWindow(newWindow: NSWindow?) {
        super.viewWillMoveToWindow(newWindow)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name:NSWindowDidResignKeyNotification, object:self.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:NSWindowDidBecomeKeyNotification, object:self.window)
    }
    
    override public func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(NSControl.setNeedsDisplay),
                                                         name:NSWindowDidResignKeyNotification,
                                                         object:self.window)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:#selector(NSControl.setNeedsDisplay),
                                                         name:NSWindowDidBecomeKeyNotification,
                                                         object:self.window)
    }

    // MARK: - Public Methods
    
    public func useItemsTree(itemsTree: Array<JumpBarItemProtocol>) {
        self.menu = NSMenu.menuWithSegmentsTree(itemsTree, target:self, action:#selector(JumpBarControl.selectJumpBarControlItem(_:)))
        
        if self.menu?.itemArray.count > 0 {
            self.selectedIndexPath = NSIndexPath(index:0);
        }
        
        if self.menu != nil && self.changeFontAndImageInMenu {
            self.changeFontAndImageInMenu(self.menu!);
        }
        
        self.layoutSegments();
    }
    
    @objc private func selectJumpBarControlItem(sender: NSMenuItem) {
    
        let nextSelectedIndexPath = sender.indexPath()
        let nextSelectedItem: JumpBarItemProtocol = sender.representedObject as! JumpBarItemProtocol
    
        self.delegate?.jumpBarControl(self, willSelectItem: nextSelectedItem, atIndexPath: nextSelectedIndexPath)
        
        self.selectedIndexPath = nextSelectedIndexPath
        self.layoutSegments()
    
        self.delegate?.jumpBarControl(self, didSelectItem: nextSelectedItem, atIndexPath: nextSelectedIndexPath)
    }
    
    public func item(atIndexPath indexPath: NSIndexPath) -> JumpBarItemProtocol? {
        guard let item = self.menu?.menuItemAtIndexPath(self.selectedIndexPath) else {
            return nil
        }
        return item.representedObject as? JumpBarItemProtocol // Return representedObject as NSMenuItem are kept hidden
    }
    
    public func selectedItem() -> JumpBarItemProtocol? {
        if let ip = self.selectedIndexPath {
            return self.item(atIndexPath: ip)
        }
        return nil
    }
    
    public func select() {
        self.isSelected = true
        for segmentControl in self.segmentControls() {
            segmentControl.select()
        }
        self.setNeedsDisplay()
    }

    public func deselect() {
        self.isSelected = false
        for segmentControl in self.segmentControls() {
            segmentControl.deselect()
        }
        self.setNeedsDisplay()
    }
    
    
    // MARK: - Layout
    
    private func layoutSegmentsIfNeeded(withNewSize size:CGSize) {

        if (self.hasCompressedSegments)  {
            self.layoutSegments();
        }
        else {
            let lastSegmentControl = self.segmentControlAtLevel(self.selectedIndexPath!.length);
            let endFloat = lastSegmentControl.frame.size.width + lastSegmentControl.frame.origin.x;
    
            if (size.width < endFloat) {
                self.layoutSegments();
            }
        }
    }
    
    private func layoutSegments() {
        guard self.selectedIndexPath?.length > 0 else {
            return
        }
        
        self.hasCompressedSegments = false
        var lastSegmentControl: JumpBarSegmentControl? = nil
        var currentMenu = self.menu
        var baseX: CGFloat = 0
    
        for position in 0..<self.selectedIndexPath!.length {
            let selectedIndex = self.selectedIndexPath!.indexAtPosition(position)
    
            lastSegmentControl = self.segmentControlAtLevel(position)
            lastSegmentControl!.isLastSegment = (position == self.selectedIndexPath?.lastIndex())
            lastSegmentControl!.indexInLevel = selectedIndex
            lastSegmentControl!.select()
    
            let item = currentMenu!.itemAtIndex(selectedIndex)
            lastSegmentControl!.representedObject = item!.representedObject as? JumpBarItemProtocol;
    
            lastSegmentControl!.sizeToFit()
            var frame = lastSegmentControl!.frame
            frame.origin.x = baseX
            baseX += frame.size.width
            lastSegmentControl!.frame = frame
    
            currentMenu = item!.submenu
        }
    
        let endX = lastSegmentControl!.frame.size.width + lastSegmentControl!.frame.origin.x
    
        if self.frame.size.width < endX {
            self.hasCompressedSegments = true;
    
            var overMargin: CGFloat = CGFloat(endX - self.frame.size.width)
            
            for position in 0..<self.selectedIndexPath!.length {
                var pos = position
                if position == self.selectedIndexPath!.length {
                    pos = KPCJumpBarControlAccessoryMenuLabelTag - 1;
                }
    
                let segmentControl = self.segmentControlAtLevel(pos);
    
                if ((overMargin + segmentControl.minimumWidth() - segmentControl.frame.size.width) < 0) {
                    var frame = segmentControl.frame
                    frame.size.width -= overMargin
                    segmentControl.frame = frame
                    break;
                }
                else {
                    overMargin -= (segmentControl.frame.size.width - segmentControl.minimumWidth())
                    var frame = segmentControl.frame
                    frame.size.width = segmentControl.minimumWidth()
                    segmentControl.frame = frame;
                }
            }
    
            var baseX: CGFloat = CGFloat(0);
            for position in 0..<self.selectedIndexPath!.length {
                let segmentControl = self.segmentControlAtLevel(position);
                var frame = segmentControl.frame;
                frame.origin.x = baseX;
                baseX += frame.size.width;
                segmentControl.frame = frame;
            }
        }
    }
    
    // MARK: - Drawing
    
    override public func drawRect(dirtyRect: NSRect) {
    
        var newRect = dirtyRect
        newRect.size.height = self.bounds.size.height;
        newRect.origin.y = 0;
    
        var mainGradient: NSGradient? = nil;
        if (!self.isSelected || !self.enabled || !(self.window?.keyWindow)!) {
            mainGradient = NSGradient(startingColor:NSColor(calibratedWhite:0.96, alpha:1.0),
                                      endingColor:NSColor(calibratedWhite:0.94, alpha:1.0));                
        }
        else {
            mainGradient = NSGradient(startingColor:NSColor(calibratedWhite:0.85, alpha:1.0),
                                      endingColor:NSColor(calibratedWhite:0.83, alpha:1.0));
        }
    
        mainGradient!.drawInRect(newRect, angle:-90);
    
        NSColor(calibratedWhite:0.7, alpha:1.0).set()
        // bottom line
        newRect.size.height = 1;
        NSRectFill(newRect);
        // top line
        newRect.origin.y = self.frame.size.height - 1;
        NSRectFill(newRect);
    }
    
    
    // MARK: - Helpers
    
    private func segmentControlAtLevel(level: Int) -> JumpBarSegmentControl {
        
        var segmentControl: JumpBarSegmentControl? = self.viewWithTag(level) as! JumpBarSegmentControl?;
        if (segmentControl == nil || segmentControl == self) { // Check for == self is when at root.
            segmentControl = JumpBarSegmentControl()
            segmentControl!.tag = level;
            segmentControl!.frame = NSMakeRect(0, 0, 0, self.frame.size.height);
            segmentControl!.delegate = self;
            segmentControl!.enabled = self.enabled;
            self.addSubview(segmentControl!)
        }
        
        return segmentControl!
    }
    
    private func changeFontAndImageInMenu(subMenu: NSMenu) {
//    for (NSMenuItem *item in [subMenu itemArray]) {
//    NSMutableAttributedString *attributedString = [[item attributedTitle] mutableCopy];
//    if (attributedString == nil) {
//    attributedString = [[NSMutableAttributedString alloc] initWithString:item.title];
//    }
//    
//    NSDictionary *attribues = (attributedString.length != 0) ? [attributedString attributesAtIndex:0 effectiveRange:nil] : nil;
//    NSFont *font = [attribues objectForKey:NSFontAttributeName];
//    NSString *fontDescrition = [font fontName];
//    
//    if (fontDescrition != nil) {
//    if ([fontDescrition rangeOfString:@"Bold" options:NSCaseInsensitiveSearch].location != NSNotFound) {
//    font = [NSFont boldSystemFontOfSize:12.0];
//    }
//    else {
//    font = [NSFont systemFontOfSize:12.0];
//    }
//    }
//    else {
//    font = [NSFont systemFontOfSize:12.0];
//    }
//    
//    [attributedString addAttributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]
//    range:NSMakeRange(0, attributedString.length)];
//    
//    [item setAttributedTitle:attributedString];
//    [item.image setSize:NSMakeSize(KPCJumpBarControlNormalImageSize, KPCJumpBarControlNormalImageSize)];
//    
//    if ([item hasSubmenu]) {
//    [self changeFontAndImageInMenu:[item submenu]];
//    }
//    }
    }
    
    private func segmentControls() -> Array<JumpBarSegmentControl> {
        return self.subviews.filter({ $0.isKindOfClass(JumpBarSegmentControl) }) as! Array<JumpBarSegmentControl>
    }
    
    // MARK: - JumpBarSegmentControlDelegate
    
    func jumpBarSegmentControlDidReceiveMouseDown(segmentControl: JumpBarSegmentControl) {
        
        let subIndexPath = self.selectedIndexPath!.subIndexPathToPosition(segmentControl.tag+1); // To be inclusing, one must add 1
        let clickedMenu = self.menu!.menuItemAtIndexPath(subIndexPath)!.menu;

        var items = [JumpBarItemProtocol]()
        for menuItem in clickedMenu!.itemArray {
            items.append(menuItem.representedObject as! JumpBarItemProtocol)
        }
    
        self.delegate?.jumpBarControl(self, willOpenMenuAtIndexPath:subIndexPath, withItems:items)
        
        // Avoid to call menuWillOpen: as it will duplicate with popUpMenuPositioningItem:...
        let menuDelegate = clickedMenu!.delegate;
        clickedMenu!.delegate = nil;
    
        let xPoint = (self.tag == KPCJumpBarItemControlAccessoryMenuLabelTag) ? CGFloat(-9) : CGFloat(-16);
        
        clickedMenu!.popUpMenuPositioningItem(clickedMenu?.itemAtIndex(segmentControl.indexInLevel),
                                              atLocation:NSMakePoint(xPoint , segmentControl.frame.size.height - 4),
                                              inView:segmentControl)

        clickedMenu!.delegate = menuDelegate;

        items = [JumpBarItemProtocol]()
        for menuItem in clickedMenu!.itemArray {
            items.append(menuItem.representedObject as! JumpBarItemProtocol)
        }

        self.delegate?.jumpBarControl(self, didOpenMenuAtIndexPath:subIndexPath, withItems:items)
    }
}



