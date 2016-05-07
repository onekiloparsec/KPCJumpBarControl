//
//  ViewController.m
//  KPCJumpBarControlDemo
//
//  Created by Cédric Foellmi on 01/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

#import "ViewController.h"
#import <KPCJumpBarControl/KPCJumpBarControl.h>

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    KPCJumpBarItem *rootSegment = [KPCJumpBarItem itemWithTitle:@"level 0" icon:[NSImage imageNamed:@"Oval"]];
    
    KPCJumpBarItem *segment1Item0 = [KPCJumpBarItem itemWithTitle:@"level 1.0" icon:[NSImage imageNamed:@"Polygon"]];
    KPCJumpBarItem *segment1Item1 = [KPCJumpBarItem itemWithTitle:@"level 1.1" icon:[NSImage imageNamed:@"Rectangle"]];
    
    rootSegment.children = @[segment1Item0, segment1Item1];
    
    [self.jumpBar useItemsTree:@[rootSegment] target:self action:@selector(printAction:)];
}

- (void)printAction:(id)sender
{
    NSLog(@"Hey! %@", sender);
}


@end
