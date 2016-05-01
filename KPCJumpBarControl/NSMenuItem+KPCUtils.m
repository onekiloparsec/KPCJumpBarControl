//
//  NSMenuItem+KPCUtils.m
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 01/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

#import "NSMenuItem+KPCUtils.h"
#import "NSIndexPath+KPCUtils.h"

@implementation NSMenuItem (KPCUtils)

- (NSIndexPath *)KPC_indexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    NSMenu *menu = self.menu;
    NSMenuItem *item = self;
    
    while (menu != nil) {
        NSInteger currentIndex = [menu indexOfItem:item];
        indexPath = [indexPath KPC_indexPathByAddingIndexInFront:currentIndex];
        NSInteger itemIndex = [menu.supermenu indexOfItemWithSubmenu:menu];
        menu = menu.supermenu;
        item = [menu itemAtIndex:itemIndex];
    }
    
    return indexPath;
}

@end
