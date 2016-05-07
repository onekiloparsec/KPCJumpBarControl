//
//  ViewController.h
//  KPCJumpBarControlDemo
//
//  Created by Cédric Foellmi on 01/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KPCJumpBarControl;

@interface ViewController : NSViewController

@property(nonatomic, weak) IBOutlet KPCJumpBarControl *jumpBar;

@property(nonatomic, weak) IBOutlet NSTextField *selectedItemTitle;
@property(nonatomic, weak) IBOutlet NSImageView *selectedItemIcon;
@property(nonatomic, weak) IBOutlet NSTextField *selectedItemIndexPath;

@end

