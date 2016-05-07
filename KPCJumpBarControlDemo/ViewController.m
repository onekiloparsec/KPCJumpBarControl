//
//  ViewController.m
//  KPCJumpBarControlDemo
//
//  Created by Cédric Foellmi on 01/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

#import "ViewController.h"
#import <KPCJumpBarControl/KPCJumpBarControl.h>

@interface ViewController () <KPCJumpBarControlDelegate>
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedItemIcon.image = nil;
    self.selectedItemTitle.stringValue = @"";
    self.selectedItemIndexPath.stringValue = @"";

    KPCJumpBarItem *rootSegment = [KPCJumpBarItem itemWithTitle:@"level 0" icon:[NSImage imageNamed:@"Oval"]];
    
    KPCJumpBarItem *segment1Item0 = [KPCJumpBarItem itemWithTitle:@"level 1.0" icon:[NSImage imageNamed:@"Polygon"]];
    KPCJumpBarItem *segment1Item1 = [KPCJumpBarItem itemWithTitle:@"level 1.1" icon:[NSImage imageNamed:@"Rectangle"]];
    KPCJumpBarItem *segment1Item2 = [KPCJumpBarItem itemWithTitle:@"level 1.2" icon:[NSImage imageNamed:@"Triangle"]];
    
    rootSegment.children = @[segment1Item0, segment1Item1, segment1Item2];

    KPCJumpBarItem *segment2Item0 = [KPCJumpBarItem itemWithTitle:@"level 2.0" icon:[NSImage imageNamed:@"Star"]];
    KPCJumpBarItem *segment2Item1 = [KPCJumpBarItem itemWithTitle:@"level 2.1" icon:[NSImage imageNamed:@"Spiral"]];
    
    segment1Item1.children = @[segment2Item0, segment2Item1];

    [self.jumpBar useItemsTree:@[rootSegment]];
    
    self.jumpBar.delegate = self;
}

#pragma mark - KPCJumpBarControlDelegate 

- (void)jumpBarControl:(KPCJumpBarControl * _Nonnull)jumpBar willOpenMenuAtIndexPath:(NSIndexPath * _Nonnull)indexPath withItems:(NSArray <id<KPCJumpBarItem>> * _Nonnull)items
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)jumpBarControl:(KPCJumpBarControl * _Nonnull)jumpBar didOpenMenuAtIndexPath:(NSIndexPath * _Nonnull)indexPath withItems:(NSArray <id<KPCJumpBarItem>> * _Nonnull)items
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)jumpBarControl:(KPCJumpBarControl * _Nonnull)jumpBar willSelectItem:(id<KPCJumpBarItem> _Nonnull)item atIndexPath:(NSIndexPath * _Nonnull)indexPath
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)jumpBarControl:(KPCJumpBarControl * _Nonnull)jumpBar didSelectItem:(id<KPCJumpBarItem> _Nonnull)item atIndexPath:(NSIndexPath * _Nonnull)indexPath
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    self.selectedItemIcon.image = [item icon];
    self.selectedItemTitle.stringValue = [item title];
    self.selectedItemIndexPath.stringValue = [@"IndexPath: " stringByAppendingString:[indexPath KPC_stringValue]];
}


@end
