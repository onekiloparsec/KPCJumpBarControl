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

#pragma mark - Public Methods -

- (void)useItemsTree:(NSArray <id<KPCJumpBarItem>> * _Nonnull)itemsTree
{
    self.menu = [NSMenu KPC_menuWithSegmentsTree:itemsTree target:self action:@selector(selectJumpBarControlItem:)];
    
    if (self.menu != nil && [[self.menu itemArray] count] > 0) {
        self.selectedIndexPath = [NSIndexPath indexPathWithIndex:0];
    }
    if (self.changeFontAndImageInMenu) {
        [self changeFontAndImageInMenu:self.menu];
    }

    [self layoutSegments];
}

- (void)selectJumpBarControlItem:(NSMenuItem *)sender
{
    NSIndexPath *nextSelectedIndexPath = [sender KPC_indexPath];
    id<KPCJumpBarItem> nextSelectedItem = [sender representedObject];
    
    if ([self.delegate respondsToSelector:@selector(jumpBarControl:willSelectItem:atIndexPath:)]) {
        [self.delegate jumpBarControl:self willSelectItem:nextSelectedItem atIndexPath:nextSelectedIndexPath];
    }

    self.selectedIndexPath = nextSelectedIndexPath;
    [self layoutSegments];

    if ([self.delegate respondsToSelector:@selector(jumpBarControl:didSelectItem:atIndexPath:)]) {
        [self.delegate jumpBarControl:self didSelectItem:nextSelectedItem atIndexPath:nextSelectedIndexPath];
    }
}

- (id<KPCJumpBarItem> _Nullable)itemAtIndexPath:(NSIndexPath * _Nonnull)indexPath
{
    return [[self.menu KPC_menuItemAtIndexPath:self.selectedIndexPath] representedObject];
}

- (id<KPCJumpBarItem> _Nullable)selectedItem
{
    return [self itemAtIndexPath:self.selectedIndexPath];
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

#pragma mark - Overrides

- (BOOL)isFlipped
{
    return YES;
}

- (NSMenu *)menuForEvent:(NSEvent *)event
{
    return nil;
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

- (void)layoutSegments
{
    self.hasCompressedSegments = NO;
    KPCJumpBarSegmentControl *lastSegmentControl = nil;
    NSMenu *currentMenu = self.menu;
    CGFloat baseX = 0;
    
    for (NSUInteger position = 0; position < self.selectedIndexPath.length; position ++) {
        NSUInteger selectedIndex = [self.selectedIndexPath indexAtPosition:position];
        
        KPCJumpBarSegmentControl *lastSegmentControl = [self segmentControlAtLevel:position];
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

//- (void)renameComponentWithText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
//{
//    NSMenuItem *componentItem = [self.menu KPC_menuItemAtIndexPath:indexPath];
//    NSMenu *componentMenu = componentItem.menu;
//    NSInteger index = [componentMenu indexOfItem:componentItem];
//    
//    NSMenuItem *newItem = [[NSMenuItem alloc] initWithTitle:text
//                                                     action:componentItem.action
//                                              keyEquivalent:componentItem.keyEquivalent];
//    
//    [newItem setEnabled:[componentItem isEnabled]];
//    [newItem setIndentationLevel:[componentItem indentationLevel]];
//    [newItem setImage:[componentItem image]];
//    [newItem setTarget:[componentItem target]];
//    [newItem setTag:[componentItem tag]];
//    [newItem setState:[componentItem state]];
//    [newItem setSubmenu:[componentItem submenu]];
//    [newItem setToolTip:[componentItem toolTip]];
//    [newItem setRepresentedObject:[componentItem representedObject]];
//    
//    [componentMenu setTitle:text];
//    [componentMenu insertItem:newItem atIndex:index];
//    [componentMenu removeItemAtIndex:index+1];
//    
//    [self layoutSegments];
//}

#pragma mark - KPCJumpBarSegmentControlDelegate

- (void)jumpBarSegmentControlDidReceiveMouseDown:(KPCJumpBarSegmentControl *)segmentControl
{
    NSIndexPath *subIndexPath = [self.selectedIndexPath KPC_subIndexPathToPosition:segmentControl.tag+1]; // To be inclusing, one must add 1
    NSMenu *clickedMenu = [[self.menu KPC_menuItemAtIndexPath:subIndexPath] menu];
    NSArray *items = [[clickedMenu itemArray] valueForKey:@"representedObject"];
    
    if ([self.delegate respondsToSelector:@selector(jumpBarControl:willOpenMenuAtIndexPath:withItems:)]) {
        [self.delegate jumpBarControl:self willOpenMenuAtIndexPath:subIndexPath withItems:items];
    }
    
    // Avoid to call menuWillOpen: as it will duplicate with popUpMenuPositioningItem:...
    id<NSMenuDelegate> menuDelegate = clickedMenu.delegate;
    clickedMenu.delegate = nil;
    
    CGFloat xPoint = (self.tag == KPCJumpBarItemControlAccessoryMenuLabelTag ? - 9 : - 16);
    [clickedMenu popUpMenuPositioningItem:[clickedMenu itemAtIndex:segmentControl.indexInLevel]
                               atLocation:NSMakePoint(xPoint , segmentControl.frame.size.height - 4)
                                   inView:segmentControl];
    
    clickedMenu.delegate = menuDelegate;
    
    items = [[clickedMenu itemArray] valueForKey:@"representedObject"]; // Better to grab them again, as it may have change a bit inside.
    
    if ([self.delegate respondsToSelector:@selector(jumpBarControl:didOpenMenuAtIndexPath:withItems:)]) {
        [self.delegate jumpBarControl:self didOpenMenuAtIndexPath:subIndexPath withItems:items];
    }
}

@end


