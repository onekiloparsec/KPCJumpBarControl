//
//  JumpBarControl.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

public enum IndexPathError: Error {
    case empty(String)
    case invalid(String)
}

open class JumpBarControl: NSControl, JumpBarSegmentControlDelegate {
    let KPCJumpBarControlTag: NSInteger = -9999999

    open weak var delegate: JumpBarControlDelegate? = nil
    open fileprivate(set) var selectedIndexPath: IndexPath? = nil
    
    fileprivate var hasCompressedSegments: Bool = false
    fileprivate var isSelected: Bool = false
    
    // MARK: - Overrides
    
    override open var isFlipped: Bool {
        get { return true }
    }
    
    override open var isEnabled: Bool {
        didSet {
            for segmentControl in self.segmentControls() {
                segmentControl.isEnabled = self.isEnabled
            }
            self.setNeedsDisplay()
        }
    }
    
    override open var frame: NSRect {
        didSet {
            self.layoutSegmentsIfNeeded(withNewSize:super.frame.size)
        }
    }

    override open var bounds: NSRect {
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

    fileprivate func setup() {
        self.tag = KPCJumpBarControlTag
        self.isEnabled = true
    }

    override open func menu(for event: NSEvent) -> NSMenu? {
        return nil
    }
    
    // MARK: - Window

    override open func viewWillMove(toWindow newWindow: NSWindow?) {
        super.viewWillMove(toWindow: newWindow)
        
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.NSWindowDidResignKey, object:self.window)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.NSWindowDidBecomeKey, object:self.window)
    }
    
    override open func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(JumpBarControl.setControlNeedsDisplay),
                                               name:NSNotification.Name.NSWindowDidResignKey,
                                               object:self.window)
        
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(JumpBarControl.setControlNeedsDisplay),
                                               name:NSNotification.Name.NSWindowDidBecomeKey,
                                               object:self.window)
    }
    
    open func setControlNeedsDisplay() {
        self.setNeedsDisplay()
    }

    // MARK: - Public Methods
    
    open func useItemsTree(_ itemsTree: Array<JumpBarItemProtocol>) {
        self.segmentControls().forEach { $0.removeFromSuperview() }
        self.selectedIndexPath = nil
        
        self.menu = NSMenu.menuWithSegmentsTree(itemsTree, target:self, action:#selector(JumpBarControl.selectJumpBarControlItem(_:)))
        
        self.layoutSegments()
        
        if self.menu?.items.count > 0 {
            self.selectJumpBarControlItem(self.menu!.items.first!)
        }
    }
    
    @objc fileprivate func selectJumpBarControlItem(_ sender: NSMenuItem) {
    
        let nextSelectedIndexPath = sender.indexPath()
        let nextSelectedItem: JumpBarItemProtocol = sender.representedObject as! JumpBarItemProtocol
    
        self.delegate?.jumpBarControl(self, willSelectItem: nextSelectedItem, atIndexPath: nextSelectedIndexPath)
        
        self.removeSegments(fromLevel: nextSelectedIndexPath.count)
        self.selectedIndexPath = nextSelectedIndexPath
        self.layoutSegments()
    
        self.delegate?.jumpBarControl(self, didSelectItem: nextSelectedItem, atIndexPath: nextSelectedIndexPath)
    }
    
    open func item(atIndexPath indexPath: IndexPath) -> JumpBarItemProtocol? {
        guard let item = self.menu?.menuItemAtIndexPath(self.selectedIndexPath) else {
            return nil
        }
        return item.representedObject as? JumpBarItemProtocol // Return representedObject as NSMenuItem are kept hidden
    }
    
    open func selectedItem() -> JumpBarItemProtocol? {
        if let ip = self.selectedIndexPath {
            return self.item(atIndexPath: ip)
        }
        return nil
    }
    
    open func select() {
        self.isSelected = true
        for segmentControl in self.segmentControls() {
            segmentControl.select()
        }
        self.setNeedsDisplay()
    }

    open func deselect() {
        self.isSelected = false
        for segmentControl in self.segmentControls() {
            segmentControl.deselect()
        }
        self.setNeedsDisplay()
    }
    
    
    // MARK: - Layout
    
    fileprivate func removeSegments(fromLevel level: Int) {
        if level < self.selectedIndexPath?.count {
            for l in level..<self.selectedIndexPath!.count {
                if let superfluousSegmentControl = self.segmentControlAtLevel(l, createIfNecessary: false) {
                    superfluousSegmentControl.removeFromSuperview()
                }
            }
        }
    }
    
    fileprivate func layoutSegmentsIfNeeded(withNewSize size:CGSize) {

        if (self.hasCompressedSegments)  {
            self.layoutSegments() // always layout segments when compressed.
        }
        else {
            if let lastSegmentControl = self.segmentControlAtLevel(self.selectedIndexPath!.count-1, createIfNecessary: false) {
                let maxNewControlWidth = size.width
                let currentControlWidth = lastSegmentControl.frame.maxX
                if (currentControlWidth > maxNewControlWidth) {
                    self.layoutSegments()
                }
            }
        }
    }
    
    fileprivate func layoutSegments() {
        let totalWidth = self.prepareSegmentsLayout()
        if totalWidth <= 0 {
            return
        }
        
        self.hasCompressedSegments = self.frame.width < totalWidth
        
        var originX = CGFloat(0)
        var widthReduction = CGFloat(0)
        
        if self.hasCompressedSegments {
            widthReduction = (totalWidth - self.frame.width)/CGFloat(self.selectedIndexPath!.count)
        }
        
        for position in 0..<self.selectedIndexPath!.count {
            let segmentControl = self.segmentControlAtLevel(position)!
            var frame = segmentControl.frame
            frame.origin.x = originX
            frame.size.width -= widthReduction
            originX += frame.size.width
            segmentControl.frame = frame
        }        
    }
    
    fileprivate func prepareSegmentsLayout() -> CGFloat {
        guard self.selectedIndexPath?.count > 0 else {
            return CGFloat(0)
        }
        
        var currentMenu = self.menu
        var totalWidth = CGFloat(0)
        
        for (position, index) in self.selectedIndexPath!.enumerated() {
            
            let segment = self.segmentControlAtLevel(position)!
            segment.isLastSegment = (position == self.selectedIndexPath!.count-1)
            segment.indexInPath = index
            segment.select()
            
            let item = currentMenu!.item(at: index)
            segment.representedObject = item!.representedObject as? JumpBarItemProtocol
            currentMenu = item!.submenu
            
            segment.sizeToFit()
            totalWidth += segment.frame.width
        }
        
        return totalWidth
    }
    
    // MARK: - Drawing
    
    override open func draw(_ dirtyRect: NSRect) {
    
        var newRect = dirtyRect
        newRect.size.height = self.bounds.size.height
        newRect.origin.y = 0
    
        var mainGradient: NSGradient? = nil
        if (!self.isSelected || !self.isEnabled || !(self.window?.isKeyWindow)!) {
            mainGradient = NSGradient(starting:NSColor(calibratedWhite:0.96, alpha:1.0),
                                      ending:NSColor(calibratedWhite:0.94, alpha:1.0))                
        }
        else {
            mainGradient = NSGradient(starting:NSColor(calibratedWhite:0.85, alpha:1.0),
                                      ending:NSColor(calibratedWhite:0.83, alpha:1.0))
        }
    
        mainGradient!.draw(in: newRect, angle:-90)
    
        NSColor(calibratedWhite:0.7, alpha:1.0).set()
        // bottom line
        newRect.size.height = 1
        NSRectFill(newRect)
        // top line
        newRect.origin.y = self.frame.size.height - 1
        NSRectFill(newRect)
    }
    
    
    // MARK: - Helpers
    
    fileprivate func segmentControlAtLevel(_ level: Int, createIfNecessary: Bool = true) -> JumpBarSegmentControl? {
        
        var segmentControl: JumpBarSegmentControl? = self.viewWithTag(level) as! JumpBarSegmentControl?
        
        if (segmentControl == nil || segmentControl == self) && createIfNecessary == true { // Check for == self is when at root.
            segmentControl = JumpBarSegmentControl()
            segmentControl!.tag = level
            segmentControl!.frame = NSMakeRect(0, 0, 0, self.frame.size.height)
            segmentControl!.delegate = self
            segmentControl!.isEnabled = self.isEnabled
            self.addSubview(segmentControl!)
        }
        
        return segmentControl
    }
    
    fileprivate func segmentControls() -> Array<JumpBarSegmentControl> {
        return self.subviews.filter({ $0.isKind(of: JumpBarSegmentControl.self) }) as! Array<JumpBarSegmentControl>
    }
    
    // MARK: - JumpBarSegmentControlDelegate
    
    func jumpBarSegmentControlDidReceiveMouseDown(_ segmentControl: JumpBarSegmentControl) {
        
        let subIndexPath = self.selectedIndexPath!.prefix(through: segmentControl.tag) // To be inclusive, we use 'through' rather than 'upTo'
        let clickedMenu = self.menu!.menuItemAtIndexPath(subIndexPath)!.menu

        var items = [JumpBarItemProtocol]()
        for menuItem in clickedMenu!.items {
            items.append(menuItem.representedObject as! JumpBarItemProtocol)
        }
    
        self.delegate?.jumpBarControl(self, willOpenMenuAtIndexPath:subIndexPath, withItems:items)
        
        // Avoid to call menuWillOpen: as it will duplicate with popUpMenuPositioningItem:...
        let menuDelegate = clickedMenu!.delegate
        clickedMenu!.delegate = nil
    
        let xPoint = (self.tag == KPCJumpBarItemControlAccessoryMenuLabelTag) ? CGFloat(-9) : CGFloat(-16)
        
        clickedMenu!.popUp(positioning: clickedMenu?.item(at: segmentControl.indexInPath),
                           at:NSMakePoint(xPoint, segmentControl.frame.size.height - 4),
                           in:segmentControl)

        clickedMenu!.delegate = menuDelegate

        items = [JumpBarItemProtocol]()
        for menuItem in clickedMenu!.items {
            items.append(menuItem.representedObject as! JumpBarItemProtocol)
        }

        self.delegate?.jumpBarControl(self, didOpenMenuAtIndexPath:subIndexPath, withItems:items)
    }
}



