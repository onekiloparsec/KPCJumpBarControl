//
//  KPCJumpBarItemControl.m
//  KPCJumpBarDemo
//
//  Created by Cédric Foellmi on 01/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCJumpBarSegmentControl.h"
#import "KPCJumpBarItem.h"
#import "NSIndexPath+KPCUtils.h"

const CGFloat KPCJumpBarItemControlMargin = 4.0;
const NSInteger KPCJumpBarItemControlAccessoryMenuLabelTag = -1;


@interface KPCJumpBarSegmentControl ()
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, retain) NSMenu *clickedMenu;
@end


@implementation KPCJumpBarSegmentControl

#pragma mark - View subclass

- (void)sizeToFit 
{
    [super sizeToFit];
    
    CGFloat width = (2 + (self.representedObject.icon != nil)) * KPCJumpBarItemControlMargin;
    
    NSSize textSize = [self.representedObject.title sizeWithAttributes:[self attributes]];
    width += ceil(textSize.width);
    width += ceil(self.representedObject.icon.size.width);
    if (!self.isLastSegment) {
		width += 7; //Separator image
	}
    
    NSRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

#pragma mark - Getter/Setters

- (CGFloat)minimumWidth 
{
    return KPCJumpBarItemControlMargin +
        self.representedObject.icon.size.width +
        (self.representedObject.icon != nil) * KPCJumpBarItemControlMargin +
        (self.isLastSegment == NO) * 7;
}

- (void)select
{
	self.selected = YES;
	[self setNeedsDisplay:YES];
}

- (void)deselect
{
	self.selected = NO;
	[self setNeedsDisplay:YES];
}

#pragma mark - Delegate

- (void)mouseDown:(NSEvent *)theEvent 
{
    if (self.isEnabled) {
		self.selected = YES;
		
        self.clickedMenu = [self.delegate menuToPresentWhenClickedForJumpBarLabel:self];
		
		// Avoid to call menuWillOpen: as it will duplicate with popUpMenuPositioningItem:...
		id<NSMenuDelegate> menuDelegate = self.clickedMenu.delegate;
        self.clickedMenu.delegate = nil;
		
        CGFloat xPoint = (self.tag == KPCJumpBarItemControlAccessoryMenuLabelTag ? - 9 : - 16);
        [self.clickedMenu popUpMenuPositioningItem:[self.clickedMenu itemAtIndex:self.indexInLevel] 
                                        atLocation:NSMakePoint(xPoint , self.frame.size.height - 4) 
											inView:self];  
		
		self.clickedMenu.delegate = menuDelegate;
    }
}


#pragma mark - Drawing

- (void)drawRect:(NSRect)dirtyRect 
{
    CGFloat baseLeft = 0;
	CGFloat fraction = (self.isSelected) ? 1.0 : 0.9;
    NSDictionary *attributes = [self attributes];
	
    if (self.tag == KPCJumpBarItemControlAccessoryMenuLabelTag) {
        NSImage *separatorImage = [NSImage imageNamed:@"KPCJumpBarAccessorySeparator"];
        NSPoint p = NSMakePoint(baseLeft + 1, self.frame.size.height / 2.0 - separatorImage.size.height / 2.0);
        [separatorImage drawAtPoint:p fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:fraction];
        baseLeft += separatorImage.size.width + KPCJumpBarItemControlMargin;
    }
    else {
		baseLeft = KPCJumpBarItemControlMargin; 
	}
    
    if (self.representedObject.icon != nil) {
        NSPoint p = NSMakePoint(baseLeft, floorf(self.frame.size.height / 2.0 - self.representedObject.icon.size.height / 2.0));
        [self.representedObject.icon drawAtPoint:p fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:fraction];
        baseLeft += ceil(self.representedObject.icon.size.width) + KPCJumpBarItemControlMargin;
    }
    
    if (self.representedObject.title != nil) {
        CGFloat width = self.frame.size.width - baseLeft - KPCJumpBarItemControlMargin;
        if (!self.isLastSegment && self.tag != KPCJumpBarItemControlAccessoryMenuLabelTag) width -= 7.0;
        
        if (width > 0) {
			CGRect r = CGRectMake(baseLeft, 1.0, width, 20.0);
            [self.representedObject.title drawInRect:r withAttributes:attributes];
            baseLeft += width + KPCJumpBarItemControlMargin;
        }
    }
    
    if (!self.isLastSegment && self.tag != KPCJumpBarItemControlAccessoryMenuLabelTag) {
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        NSImage *separatorImage = [bundle imageForResource:@"KPCJumpBarSeparator"];
        NSPoint o = NSMakePoint(baseLeft-3, 4.0);
        NSRect r = NSMakeRect(o.x, o.y, 11, 16);
        [separatorImage drawInRect:r fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:fraction];
    }
}

#pragma mark - Helper

- (NSDictionary *)attributes 
{
    NSShadow *highlightShadow = [[NSShadow alloc] init];
    highlightShadow.shadowOffset = CGSizeMake(0, -1.0);
    highlightShadow.shadowColor = [NSColor colorWithCalibratedWhite:1.0 alpha:0.5];
    highlightShadow.shadowBlurRadius = 0.0;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByTruncatingTail];
    
	NSColor *color = (self.isSelected) ? [NSColor colorWithCalibratedWhite:0.21 alpha:1.0] : [NSColor darkGrayColor];
	NSFont *font = (self.isSelected) ? [NSFont boldSystemFontOfSize:12.0] : [NSFont systemFontOfSize:12.0];
	
    NSDictionary *attributes = @{NSForegroundColorAttributeName: color,
                                 NSShadowAttributeName : highlightShadow,
                                 NSFontAttributeName: font,
                                 NSParagraphStyleAttributeName: style};
    
    return attributes;
}

@end
