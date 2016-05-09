//
//  KPCJumpBarControl.h
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 01/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Cocoa/Cocoa.h>

//! Project version number for KPCJumpBarControl.
FOUNDATION_EXPORT double KPCJumpBarControlVersionNumber;

//! Project version string for KPCJumpBarControl.
FOUNDATION_EXPORT const unsigned char KPCJumpBarControlVersionString[];

#import <KPCJumpBarControl/NSIndexPath+KPCUtils.h>

@protocol KPCJumpBarControlDelegate;

@interface KPCJumpBarControl : NSControl

@property(nullable, nonatomic, assign) IBOutlet id<KPCJumpBarControlDelegate> delegate;

- (void)useItemsTree:(NSArray <id<KPCJumpBarItem>> * _Nonnull)itemsTree;

- (id<KPCJumpBarItem> _Nullable)itemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (NSIndexPath * _Nullable)selectedIndexPath;
- (id<KPCJumpBarItem> _Nullable)selectedItem;

@end

