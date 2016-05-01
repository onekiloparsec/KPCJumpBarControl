//
//  KPCJumpBarItem.h
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 01/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

@protocol KPCJumpBarItem <NSObject>

- (NSString * _Nullable)title;
- (NSImage * _Nullable)icon;
- (NSArray <id<KPCJumpBarItem>> * _Nullable)children;

- (id _Nullable)target;
- (SEL _Nullable)action;

- (BOOL)isSeparator;

@end

@interface KPCJumpBarItem : NSObject <KPCJumpBarItem>

@property(nonatomic, nullable, strong) NSString *title;
@property(nonatomic, nullable, strong) NSImage *icon;
@property(nonatomic, nullable, strong) NSArray *children;

@property(nonatomic, nullable, weak) id target;
@property(nonatomic, nullable, assign) SEL action;

@property(nonatomic, assign, getter=isSeparator) BOOL isSeparator;

+ (KPCJumpBarItem * _Nonnull)itemWithTitle:(NSString * _Nullable)title icon:(NSImage * _Nullable)icon;
+ (KPCJumpBarItem * _Nonnull)separatorItem;

@end
