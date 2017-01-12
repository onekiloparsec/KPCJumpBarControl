//
//  JumpBarControl.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 08/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

import AppKit

public enum JumpBarControlError: Error {
    case alreadyBound(String)
}

fileprivate struct JumpBarControlBinding {
    fileprivate static var treeObserverContext = 1
    fileprivate static var selectionObserverContext = 3
    fileprivate weak var treeController: NSTreeController?
    fileprivate weak var selectionController: NSObject?
    fileprivate var treeKeyPath: String
    fileprivate var selectionKeyPath: String
    
    var selectedIndexPath: IndexPath? {
        get { return self.selectionController?.value(forKey: self.selectionKeyPath) as! IndexPath? }
    }
}

open class JumpBarControl: NSControl, JumpBarSegmentControlDelegate {
    let KPCJumpBarControlTag: NSInteger = -9999999

    open weak var delegate: JumpBarControlDelegate? = nil
    public fileprivate(set) var selectedIndexPath: IndexPath?
    
    fileprivate var hasCompressedSegments: Bool = false
    fileprivate var isKey: Bool = false
    fileprivate var binding: JumpBarControlBinding?

    // MARK: - Overrides
    
    override open var isFlipped: Bool {
        get { return true }
    }
    
    override open var isEnabled: Bool {
        didSet {
            self.segmentControls().forEach({ $0.isEnabled = self.isEnabled})
            self.setNeedsDisplay()
        }
    }
    
    override open var frame: NSRect {
        didSet { self.layoutSegmentsIfNeeded(withNewSize:super.frame.size) }
    }

    override open var bounds: NSRect {
        didSet { self.layoutSegmentsIfNeeded(withNewSize:super.bounds.size) }
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
    
    // MARK: - Content
    
    open func bind(itemsTreeTo treeController: NSTreeController,
                   withKeyPath treeKeyPath: String = "arrangedObjects",
                   andSelectionTo selectionController: NSObject,
                   withKeyPath selectionKeyPath: String = "selectedIndexPath") throws
    {
        guard self.binding == nil else {
            throw JumpBarControlError.alreadyBound("JumpBarControl \(self) is already bound to tree and selection controllers. Unbind first.")
        }
        
        self.binding = JumpBarControlBinding(treeController: treeController,
                                             selectionController: selectionController,
                                             treeKeyPath: treeKeyPath,
                                             selectionKeyPath: selectionKeyPath)
        
        treeController.addObserver(self,
                                   forKeyPath: treeKeyPath,
                                   options: [.new, .old],
                                   context: &JumpBarControlBinding.treeObserverContext)
        
        selectionController.addObserver(self,
                                        forKeyPath: selectionKeyPath,
                                        options: [.new, .old],
                                        context: &JumpBarControlBinding.selectionObserverContext)
     
        self.useItemsTree(treeController.arrangedRootObjects())
    }
    
    open func unbindItemsTreeAndSelection() {
        guard self.binding != nil else {
            return
        }
        
        self.binding!.treeController?.removeObserver(self, forKeyPath: self.binding!.treeKeyPath)
        self.binding!.selectionController?.removeObserver(self, forKeyPath: self.binding!.selectionKeyPath)
        self.binding = nil
    }
    
    open override func observeValue(forKeyPath keyPath: String?,
                                    of object: Any?,
                                    change: [NSKeyValueChangeKey : Any]?,
                                    context: UnsafeMutableRawPointer?)
    {
        guard context == &JumpBarControlBinding.treeObserverContext ||
            context == &JumpBarControlBinding.selectionObserverContext else
        {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        if context == &JumpBarControlBinding.treeObserverContext {
            self.useItemsTree(self.binding!.treeController!.arrangedRootObjects())
        }
        else if context == &JumpBarControlBinding.selectionObserverContext {
            if let indexPath = change?[NSKeyValueChangeKey.newKey] as? IndexPath {
                self.select(segmentItemAtIndexPath: indexPath)
            }
        }
    }

    open func useItemsTree(_ itemsTree: [JumpBarItem]) {
        self.segmentControls().forEach { $0.removeFromSuperview() }
        self.selectedIndexPath = nil

        // At that stage, we do items all in one shot. Might be optimized later.
        self.menu = NSMenu.menuWithSegmentsTree(itemsTree,
                                                target:self,
                                                action:#selector(JumpBarControl.select(segmentItemFromMenuItem:)))
        
        self.layoutSegments()
        
        if self.menu?.items.count > 0 {
            self.select(segmentItemFromMenuItem: self.menu!.items.first!)
        }
    }
    
    // MARK: - Selection
    
    @objc fileprivate func select(segmentItemFromMenuItem sender: NSMenuItem) {
        self.select(segmentItemAtIndexPath: sender.indexPath())
    }
    
    open func select(segmentItemAtIndexPath nextSelectedIndexPath: IndexPath) {
        guard nextSelectedIndexPath != self.selectedIndexPath else {
            return
        }
        if let nextSelectedItem = self.segmentItem(atIndexPath: nextSelectedIndexPath) {
            self.delegate?.jumpBarControl(self, willSelectItem: nextSelectedItem, atIndexPath: nextSelectedIndexPath)
            
            self.removeSegments(fromLevel: 0)
            self.selectedIndexPath = nextSelectedIndexPath
            self.layoutSegments()
            
            self.delegate?.jumpBarControl(self, didSelectItem: nextSelectedItem, atIndexPath: nextSelectedIndexPath)
        }
    }
    
    open func selectedSegmentItem() -> JumpBarItem? {
        if let ip = self.selectedIndexPath {
            return self.segmentItem(atIndexPath: ip)
        }
        return nil
    }
    
    open func segmentItem(atIndexPath indexPath: IndexPath) -> JumpBarItem? {
        guard let item = self.menu?.menuItemAtIndexPath(indexPath) else {
            return nil
        }
        return item.representedObject as? JumpBarItem // Return representedObject as NSMenuItem are kept hidden
    }

    // MARK: - Activation

    open func makeKey() {
        self.isKey = true
        for segmentControl in self.segmentControls() {
            segmentControl.makeKey()
        }
        self.setNeedsDisplay()
    }

    open func resignKey() {
        self.isKey = false
        for segmentControl in self.segmentControls() {
            segmentControl.resignKey()
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
            if let indexPath = self.selectedIndexPath,
                let lastSegmentControl = self.segmentControlAtLevel(indexPath.count-1, createIfNecessary: false)
            {
                let maxNewControlWidth = size.width
                let currentControlWidth = lastSegmentControl.frame.maxX
                if (currentControlWidth > maxNewControlWidth) {
                    self.layoutSegments()
                }
            }
        }
    }
    
    fileprivate func layoutSegments() {
        guard self.selectedIndexPath?.count > 0 else {
            return
        }
        
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
            segment.makeKey()
            
            let item = currentMenu!.item(at: index)
            segment.representedObject = item!.representedObject as? JumpBarItem
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
        if (!self.isKey || !self.isEnabled || !(self.window?.isKeyWindow)!) {
            mainGradient = NSGradient(starting:NSColor(calibratedWhite:0.96, alpha:1.0),
                                      ending:NSColor(calibratedWhite:0.94, alpha:1.0))                
        }
        else {
            mainGradient = NSGradient(starting:NSColor(calibratedWhite:0.85, alpha:1.0),
                                      ending:NSColor(calibratedWhite:0.83, alpha:1.0))
        }
    
        mainGradient!.draw(in: newRect, angle:-90)
    
//        NSColor(calibratedWhite:0.7, alpha:1.0).set()
//        // bottom line
//        newRect.size.height = 1
//        NSRectFill(newRect)
//        // top line
//        newRect.origin.y = self.frame.size.height - 1
//        NSRectFill(newRect)
    }
    
    
    // MARK: - Helpers
    
    fileprivate func segmentControlAtLevel(_ level: Int, createIfNecessary: Bool = true) -> JumpBarSegmentControl? {
        guard level >= 0 else {
            return nil
        }
        
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

        var items = [JumpBarItem]()
        for menuItem in clickedMenu!.items {
            items.append(menuItem.representedObject as! JumpBarItem)
        }
    
        self.delegate?.jumpBarControl(self, willOpenMenuAtIndexPath:subIndexPath, withItems:items)
        
        // Avoid to call menuWillOpen: as it will duplicate with popUpMenuPositioningItem:...
        let menuDelegate = clickedMenu!.delegate
        clickedMenu!.delegate = nil
    
        let xPoint = (self.tag == KPCJumpBarItemControlAccessoryMenuLabelTag) ? CGFloat(-9) : CGFloat(-16)
        
        clickedMenu!.popUp(positioning: clickedMenu?.item(at: segmentControl.indexInPath),
                           at:NSMakePoint(xPoint, segmentControl.frame.size.height - 2),
                           in:segmentControl)

        clickedMenu!.delegate = menuDelegate

        items = [JumpBarItem]()
        for menuItem in clickedMenu!.items {
            items.append(menuItem.representedObject as! JumpBarItem)
        }

        self.delegate?.jumpBarControl(self, didOpenMenuAtIndexPath:subIndexPath, withItems:items)
    }
}



