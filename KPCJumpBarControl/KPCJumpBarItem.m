//
//  KPCJumpBarItem.m
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 01/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCJumpBarItem.h"

@implementation KPCJumpBarItem

- (instancetype)initWithTitle:(NSString *)title icon:(NSImage *)icon
{
    self = [super init];
    if (self) {
        self.title = title;
        self.icon = icon;
        self.isSeparator = NO;
    }
    return self;
}

+ (KPCJumpBarItem *)itemWithTitle:(NSString *)title icon:(NSImage *)icon
{
    return [[KPCJumpBarItem alloc] initWithTitle:title icon:icon];
}

+ (KPCJumpBarItem * _Nonnull)separatorItem
{
    KPCJumpBarItem *s = [KPCJumpBarItem itemWithTitle:nil icon:nil];
    s.isSeparator = YES;
    return s;
}

@end
