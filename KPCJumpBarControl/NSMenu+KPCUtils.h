//
//  NSMenu+IndexPath.h
//  KPCJumpBarDemo
//
//  Created by Guillaume Campagna on 11-05-25.
//  Licensed under the MIT License (see LICENSE file)
//

#import <AppKit/AppKit.h>
#import "KPCJumpBarItem.h"

@interface NSMenu (KPCUtils)

+ (NSMenu * _Nonnull)KPC_menuWithSegmentsTree:(NSArray <id<KPCJumpBarItem>> * _Nonnull)contentTree
                                       target:(id _Nullable)target
                                       action:(SEL _Nullable)action;

- (NSMenuItem * _Nullable)KPC_menuItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

@end
