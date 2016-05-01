//
//  KPCJumpBarControlDelegate.h
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 01/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KPCJumpBarControl;

@protocol KPCJumpBarControlDelegate <NSControlTextEditingDelegate>

@optional
- (void)jumpBarControl:(KPCJumpBarControl * _Nonnull)jumpBar willOpenMenuAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)jumpBarControl:(KPCJumpBarControl * _Nonnull)jumpBar didSelectItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

@end
