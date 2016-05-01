//
//  NSMenu+IndexPath.m
//  KPCJumpBarDemo
//
//  Created by Cédric Foellmi on 01/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

#import "NSMenu+KPCUtils.h"

@implementation NSMenu (KPCUtils)

+ (NSMenu * _Nonnull)KPC_menuWithSegmentsTree:(NSArray <id<KPCJumpBarItem>> * _Nonnull)contentTree
                                       target:(id _Nullable)target
                                       action:(SEL)action
{
    NSMenu *menu = [[NSMenu alloc] init];
    [menu setAutoenablesItems:YES];
    
    [contentTree enumerateObjectsUsingBlock:^(id<KPCJumpBarItem>  _Nonnull segment, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [menu setTitle:segment.title];
        }
        
        NSMenuItem *item = [[NSMenuItem alloc] init];
        [item setTitle:segment.title];
        [item setImage:segment.icon];
        [item setEnabled:YES];
        [item setRepresentedObject:segment];
        [item setTarget:target];
        [item setAction:action];
        [item setKeyEquivalent:@""];
        
        [menu addItem:item];
        
        if (segment.children.count > 0) {
            NSMenu *submenu = [NSMenu KPC_menuWithSegmentsTree:segment.children target:target action:action];
            [menu setSubmenu:submenu forItem:item];
        }
    }];
    
    return menu;
}

- (NSMenuItem *)KPC_menuItemAtIndexPath:(NSIndexPath *)indexPath 
{
    NSMenu *currentMenu = self;
	NSUInteger lastPosition = indexPath.length - 1;
	
	// Do not take last position.
    for (NSUInteger position = 0; position < lastPosition ; position ++) {
		NSUInteger index = [indexPath indexAtPosition:position];
		if (index >= [currentMenu numberOfItems]) {
			index = 0;
		}
		NSMenuItem *item = [currentMenu itemAtIndex:index];		
        currentMenu = [item submenu];
    }
	
	NSUInteger lastIndex = [indexPath indexAtPosition:lastPosition];
	if (lastIndex >= [currentMenu numberOfItems]) {
		lastIndex = 0;
	}
	
    if (lastIndex >= [currentMenu numberOfItems]) {
        NSLog(@"Last menu index %ld is out of bounds in items array of menu %@", lastIndex, currentMenu);
        return nil;
    }
			 
    return [currentMenu itemAtIndex:lastIndex];
}


@end
