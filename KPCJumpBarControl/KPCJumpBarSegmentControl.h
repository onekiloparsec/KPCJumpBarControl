//
//  KPCJumpBarItemControl.h
//  KPCJumpBarDemo
//
//  Created by Cédric Foellmi on 01/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Cocoa/Cocoa.h>

@protocol KPCJumpBarItem;
@protocol KPCJumpBarSegmentControlDelegate;

@interface KPCJumpBarSegmentControl : NSControl

@property (nonatomic, strong) id<KPCJumpBarItem> representedObject;
@property (nonatomic, getter=isLastSegment) BOOL isLastSegment;
@property (nonatomic, assign) NSUInteger indexInLevel;
@property (nonatomic, assign) id<KPCJumpBarSegmentControlDelegate> delegate;

- (BOOL)isLastSegment;
- (CGFloat)minimumWidth;
- (void)select;
- (void)deselect;

@end

@protocol KPCJumpBarSegmentControlDelegate <NSObject>
- (NSMenu *)menuToPresentWhenClickedForJumpBarLabel:(KPCJumpBarSegmentControl *)label;
- (void)jumpBarLabel:(KPCJumpBarSegmentControl *)label didReceivedClickOnItemAtIndexPath:(NSIndexPath *)indexPath;
@end
