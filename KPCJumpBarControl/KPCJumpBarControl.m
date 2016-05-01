//
//  KPCJumpBarControl.m
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 01/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCJumpBarControl.h"
#import "KPCJumpBarSegmentControl.h"
#import "NSMenu+KPCUtils.h"
#import "NSMenuItem+KPCUtils.h"

const CGFloat KPCJumpBarControlNormalHeight = 23.0;
const CGFloat KPCJumpBarControlNormalImageSize = 16.0;
const NSInteger KPCJumpBarControlAccessoryMenuLabelTag = -1;
const NSInteger KPCJumpBarControlTag = -9999999;

@interface KPCJumpBarControl () <KPCJumpBarSegmentControlDelegate>
@property(nonatomic, strong) NSMenu *menu;
@property(nonatomic, weak) id mainTarget;
@property(nonatomic, assign) SEL mainAction;

@property(nonatomic, strong) NSIndexPath *selectedIndexPath;

@property(nonatomic, assign) BOOL changeFontAndImageInMenu;
@property(nonatomic, assign) BOOL hasCompressedSegments;
@property(nonatomic, assign) BOOL isSelected;
@end

@implementation KPCJumpBarControl

@dynamic menu;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self KPCJumpBarControl_commonSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self KPCJumpBarControl_commonSetup];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        [self KPCJumpBarControl_commonSetup];
    }
    return self;
}

- (void)KPCJumpBarControl_commonSetup
{
    self.tag = KPCJumpBarControlTag;
    self.enabled = YES;
    self.changeFontAndImageInMenu = YES;
}

#pragma mark - Public Methods -

- (void)useItemsTree:(NSArray <id<KPCJumpBarItem>> * _Nonnull)itemsTree target:(id)target action:(SEL)action
{
    self.mainTarget = target;
    self.mainAction = action;
    self.menu = [NSMenu KPC_menuWithSegmentsTree:itemsTree target:self action:@selector(performItemAction:)];
}

- (id<KPCJumpBarItem> _Nullable)itemAtIndexPath:(NSIndexPath * _Nonnull)indexPath
{
    return [[self.menu KPC_menuItemAtIndexPath:self.selectedIndexPath] representedObject];
}

- (id<KPCJumpBarItem> _Nullable)selectedItem
{
    return [self itemAtIndexPath:self.selectedIndexPath];
}

- (void)performItemAction:(NSMenuItem *)sender
{
    self.selectedIndexPath = [sender KPC_indexPath];
    [self layoutSegments];
    
    if (self.mainTarget && self.mainAction) {
        if ([self.mainTarget respondsToSelector:self.mainAction]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.mainTarget performSelector:self.mainAction withObject:sender];
#pragma clang diagnostic pop
        }
        else {
            [NSException raise:NSInvalidArgumentException
                        format:@"Unrecognized selector '%@' send to instance %p of class '%@'",
             NSStringFromSelector(self.mainAction), self.mainTarget, NSStringFromClass([self.mainTarget class])];
        }
    }
}

#pragma mark - Overrides -

- (BOOL)isFlipped
{
    return YES;
}

- (NSMenu *)menuForEvent:(NSEvent *)event
{
    return nil;
}

- (void)setMenu:(NSMenu *)newMenu
{
    [super setMenu:newMenu];
    
    if (self.menu != nil && [[self.menu itemArray] count] > 0) {
        self.selectedIndexPath = [NSIndexPath indexPathWithIndex:0];
    }
    if (self.changeFontAndImageInMenu) {
        [self changeFontAndImageInMenu:self.menu];
    }
    
    [self layoutSegments];
    
//        if ([self.delegate respondsToSelector:@selector(jumpBar:didSelectItemAtIndexPath:)]) {
//            [self.delegate jumpBar:self didSelectItemAtIndexPath:self.selectedIndexPath];
//        }
}

- (void)setEnabled:(BOOL)flag
{
    [super setEnabled:flag];
    
    for (NSControl *view in [self subviews]) {
        [view setEnabled:flag];
    }
    
    [self setNeedsDisplay];
}

- (void)setFrame:(NSRect)frameRect
{
    [super setFrame:frameRect];
    [self layoutSegmentsIfNeededWithNewSize:frameRect.size];
}

- (void)setBounds:(NSRect)aRect
{
    [super setBounds:aRect];
    [self layoutSegmentsIfNeededWithNewSize:aRect.size];
}

#pragma mark - Layout

- (void)layoutSegmentsIfNeededWithNewSize:(CGSize)size
{
    if (self.hasCompressedSegments)  {
        [self layoutSegments];
    }
    else {
        KPCJumpBarSegmentControl *lastSegmentControl = [self segmentControlAtLevel:self.selectedIndexPath.length];
        CGFloat endFloat = lastSegmentControl.frame.size.width + lastSegmentControl.frame.origin.x;
        
        if (size.width < endFloat) {
            [self layoutSegments];
        }
    }
}

- (void)select
{
    self.isSelected = YES;
    NSArray *subviews = [self subviews];
    [subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[KPCJumpBarSegmentControl class]]) {
            [(KPCJumpBarSegmentControl *)obj select];
        }
    }];
    [self setNeedsDisplay];
}

- (void)deselect
{
    self.isSelected = NO;
    NSArray *subviews = [self subviews];
    [subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[KPCJumpBarSegmentControl class]]) {
            [(KPCJumpBarSegmentControl *)obj deselect];
        }
    }];
    [self setNeedsDisplay];
}

- (void)layoutSegments
{
    self.hasCompressedSegments = NO;
    KPCJumpBarSegmentControl *lastSegmentControl = nil;
    NSMenu *currentMenu = self.menu;

    NSIndexPath *atThisPointIndexPath = [[NSIndexPath alloc] init];
    CGFloat baseX = 0;
    
    for (NSUInteger position = 0; position < self.selectedIndexPath.length; position ++) {
        NSUInteger selectedIndex = [self.selectedIndexPath indexAtPosition:position];
        atThisPointIndexPath = [atThisPointIndexPath indexPathByAddingIndex:selectedIndex];
        
        KPCJumpBarSegmentControl *lastSegmentControl = [self segmentControlAtLevel:atThisPointIndexPath.length-1];
        lastSegmentControl.isLastSegment = (position == (self.selectedIndexPath.length - 1));
        lastSegmentControl.indexInLevel = selectedIndex;
        [lastSegmentControl select];
        
        NSMenuItem *item = [currentMenu itemAtIndex:selectedIndex];
        lastSegmentControl.representedObject = item.representedObject;
        
        [lastSegmentControl sizeToFit];
        NSRect frame = lastSegmentControl.frame;
        frame.origin.x = baseX;
        baseX += frame.size.width;
        lastSegmentControl.frame = frame;
        
        currentMenu = item.submenu;
    }

    CGFloat endX = lastSegmentControl.frame.size.width + lastSegmentControl.frame.origin.x;
    
    if (self.frame.size.width < endX) {
        self.hasCompressedSegments = YES;
        
        //Set new width for the overflow
        CGFloat overMargin = endX - self.frame.size.width;
        for (NSUInteger position = 0; position < self.selectedIndexPath.length; position ++) {
            if (position == self.selectedIndexPath.length) {
                position = KPCJumpBarControlAccessoryMenuLabelTag - 1;
            }
            
            KPCJumpBarSegmentControl *segmentControll = [self segmentControlAtLevel:position];
            
            if ((overMargin + segmentControll.minimumWidth - segmentControll.frame.size.width) < 0) {
                CGRect frame = segmentControll.frame;
                frame.size.width -= overMargin;
                segmentControll.frame = frame;
                break;
            }
            else {
                overMargin -= (segmentControll.frame.size.width - segmentControll.minimumWidth);
                CGRect frame = segmentControll.frame;
                frame.size.width = segmentControll.minimumWidth;
                segmentControll.frame = frame;
            }
        }
        
        CGFloat baseX = 0;
        for (NSUInteger position = 0; position < self.selectedIndexPath.length ; position ++) {
            KPCJumpBarSegmentControl *label = [self segmentControlAtLevel:position];
            
            NSRect frame = [label frame];
            frame.origin.x = baseX;
            baseX += frame.size.width;
            label.frame = frame;
        }
    }
}

- (void)removeUnusedLabels
{
    NSView *viewToRemove = nil;
    NSUInteger position = self.selectedIndexPath.length;
    while ((viewToRemove = [self viewWithTag:position])) {
        [viewToRemove removeFromSuperview];
        position ++;
    }
}

#pragma mark - Drawing

- (void)drawRect:(NSRect)dirtyRect
{
    dirtyRect.size.height = self.bounds.size.height;
    dirtyRect.origin.y = 0;
    
    NSGradient *mainGradient = nil;
    if (!self.isSelected || !self.isEnabled || !self.window.isKeyWindow) {
        mainGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.96 alpha:1.0]
                                                     endingColor:[NSColor colorWithCalibratedWhite:0.94 alpha:1.0]];
    }
    else {
        mainGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.85 alpha:1.0]
                                                     endingColor:[NSColor colorWithCalibratedWhite:0.83 alpha:1.0]];
    }
    
    [mainGradient drawInRect:dirtyRect angle:-90];
    
    [[NSColor colorWithCalibratedWhite:0.7 alpha:1.0] set];
    // bottom line
    dirtyRect.size.height = 1;
    NSRectFill(dirtyRect);
    // top line
    dirtyRect.origin.y = self.frame.size.height - 1;
    NSRectFill(dirtyRect);
}

- (void)viewWillMoveToWindow:(NSWindow *)newWindow
{
    [super viewWillMoveToWindow:newWindow];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSWindowDidResignKeyNotification
                                                  object:self.window];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSWindowDidBecomeKeyNotification
                                                  object:self.window];
}

- (void)viewDidMoveToWindow
{
    [super viewDidMoveToWindow];
    
    if (self.window != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setNeedsDisplay)
                                                     name:NSWindowDidResignKeyNotification
                                                   object:self.window];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setNeedsDisplay)
                                                     name:NSWindowDidBecomeKeyNotification
                                                   object:self.window];
    }
}

#pragma mark - Helper

- (KPCJumpBarSegmentControl *)segmentControlAtLevel:(NSUInteger)level
{
    KPCJumpBarSegmentControl *segmentControl = [self viewWithTag:level];
    if (segmentControl == nil || segmentControl == (id)self) { // Check for == self is when at root.
        segmentControl = [[KPCJumpBarSegmentControl alloc] init];
        segmentControl.tag = level;
        segmentControl.frame = NSMakeRect(0, 0, 0, self.frame.size.height);
        segmentControl.delegate = self;
        segmentControl.enabled = self.isEnabled;
        [self addSubview:segmentControl];
    }
    return segmentControl;
}

- (void)changeFontAndImageInMenu:(NSMenu *)subMenu
{
    for (NSMenuItem *item in [subMenu itemArray]) {
        NSMutableAttributedString *attributedString = [[item attributedTitle] mutableCopy];
        if (attributedString == nil) {
            attributedString = [[NSMutableAttributedString alloc] initWithString:item.title];
        }
        
        NSDictionary *attribues = (attributedString.length != 0) ? [attributedString attributesAtIndex:0 effectiveRange:nil] : nil;
        NSFont *font = [attribues objectForKey:NSFontAttributeName];
        NSString *fontDescrition = [font fontName];
        
        if (fontDescrition != nil) {
            if ([fontDescrition rangeOfString:@"Bold" options:NSCaseInsensitiveSearch].location != NSNotFound) {
                font = [NSFont boldSystemFontOfSize:12.0];
            }
            else {
                font = [NSFont systemFontOfSize:12.0];
            }
        }
        else {
            font = [NSFont systemFontOfSize:12.0];
        }
        
        [attributedString addAttributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]
                                  range:NSMakeRange(0, attributedString.length)];
        
        [item setAttributedTitle:attributedString];
        [item.image setSize:NSMakeSize(KPCJumpBarControlNormalImageSize, KPCJumpBarControlNormalImageSize)];
        
        if ([item hasSubmenu]) {
            [self changeFontAndImageInMenu:[item submenu]];
        }
    }
}

- (void)renameComponentWithText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
//    KPCJumpBarItemControl *label = [self viewWithTag:indexPath.length];
#warning check
//    label.representedObject.title = text;
    
    NSMenuItem *componentItem = [self.menu KPC_menuItemAtIndexPath:indexPath];
    NSMenu *componentMenu = componentItem.menu;
    NSInteger index = [componentMenu indexOfItem:componentItem];
    
    NSMenuItem *newItem = [[NSMenuItem alloc] initWithTitle:text
                                                     action:componentItem.action
                                              keyEquivalent:componentItem.keyEquivalent];
    
    [newItem setEnabled:[componentItem isEnabled]];
    [newItem setIndentationLevel:[componentItem indentationLevel]];
    [newItem setImage:[componentItem image]];
    [newItem setTarget:[componentItem target]];
    [newItem setTag:[componentItem tag]];
    [newItem setState:[componentItem state]];
    [newItem setSubmenu:[componentItem submenu]];
    [newItem setToolTip:[componentItem toolTip]];
    [newItem setRepresentedObject:[componentItem representedObject]];
    
    [componentMenu setTitle:text];
    [componentMenu insertItem:newItem atIndex:index];
    [componentMenu removeItemAtIndex:index+1];
    
    [self layoutSegments];
}

- (void)setSubmenu:(NSMenu *)subMenu atIndexPath:(NSIndexPath *)indexPath
{
    NSMenuItem *item = [self.menu KPC_menuItemAtIndexPath:indexPath];
    [item setSubmenu:subMenu];
}

- (void)setSelectedMenuItem:(NSMenuItem *)selectedMenuItem
{
    NSIndexPath* indexPath = [NSIndexPath indexPathWithIndex:[selectedMenuItem.menu indexOfItem:selectedMenuItem]];
    while (selectedMenuItem.parentItem != nil) {
        indexPath = [indexPath KPC_indexPathByAddingIndexInFront:[selectedMenuItem.menu indexOfItem:selectedMenuItem]];
        selectedMenuItem = selectedMenuItem.parentItem;
    }
    self.selectedIndexPath = indexPath;
}

#pragma mark - KPCJumpBarItemControlDelegate

- (NSMenu *)menuToPresentWhenClickedForJumpBarLabel:(KPCJumpBarSegmentControl *)label
{
    NSIndexPath *subIndexPath = [self.selectedIndexPath KPC_subIndexPathToPosition:label.tag];
    NSMenu *activeMenu = [[self.menu KPC_menuItemAtIndexPath:subIndexPath] menu];
    if ([self.delegate respondsToSelector:@selector(jumpBarControl:willOpenMenuAtIndexPath:)]) {
        [self.delegate jumpBarControl:self willOpenMenuAtIndexPath:subIndexPath];
    }
    return activeMenu;
}

- (void)jumpBarLabel:(KPCJumpBarSegmentControl *)label didReceivedClickOnItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *subIndexPath = [self.selectedIndexPath KPC_subIndexPathToPosition:label.tag - 1];
    self.selectedIndexPath = [subIndexPath KPC_indexPathByAddingIndexPath:indexPath];
}

@end


NSRect NSRectInsetWithEdgeInsets(NSRect inRect, NSEdgeInsets insets)
{
    inRect.size.height -= (insets.top + insets.bottom);
    inRect.size.width -= (insets.left + insets.right);
    inRect.origin.x += insets.left;
    inRect.origin.y += insets.top;
    return inRect;
}
