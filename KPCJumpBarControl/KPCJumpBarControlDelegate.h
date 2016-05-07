//
//  KPCJumpBarControlDelegate.h
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 01/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KPCJumpBarControl;
@protocol KPCJumpBarItem;

@protocol KPCJumpBarControlDelegate <NSControlTextEditingDelegate>

@optional
- (void)jumpBarControl:(KPCJumpBarControl * _Nonnull)jumpBar willOpenMenuAtIndexPath:(NSIndexPath * _Nonnull)indexPath withItems:(NSArray <id<KPCJumpBarItem>> * _Nonnull)items;
- (void)jumpBarControl:(KPCJumpBarControl * _Nonnull)jumpBar didOpenMenuAtIndexPath:(NSIndexPath * _Nonnull)indexPath withItems:(NSArray <id<KPCJumpBarItem>> * _Nonnull)items;

- (void)jumpBarControl:(KPCJumpBarControl * _Nonnull)jumpBar willSelectItem:(id<KPCJumpBarItem> _Nonnull)item atIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)jumpBarControl:(KPCJumpBarControl * _Nonnull)jumpBar didSelectItem:(id<KPCJumpBarItem> _Nonnull)item atIndexPath:(NSIndexPath * _Nonnull)indexPath;

@end
