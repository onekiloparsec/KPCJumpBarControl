//
//  NSIndexPath+KPCUtils.h
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 01/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (KPCUtils)

- (NSInteger)KPC_lastIndex;

- (NSIndexPath *)KPC_indexPathByAddingIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)KPC_indexPathByAddingIndexInFront:(NSInteger)index;

- (NSIndexPath *)KPC_subIndexPathFromPosition:(NSUInteger)position;
- (NSIndexPath *)KPC_subIndexPathToPosition:(NSUInteger)position;
- (NSIndexPath *)KPC_subIndexPathWithRange:(NSRange)range;

- (NSIndexPath *)KPC_indexPathByReplacingIndexAtPosition:(NSUInteger)position withIndex:(NSInteger)index;
- (NSIndexPath *)KPC_indexPathByReplacingLastIndexWithIndex:(NSInteger)index;
- (NSIndexPath *)KPC_indexPathByIncrementingLastIndex;

- (NSIndexPath *)KPC_indexPathByFillingWithIndexPath:(NSIndexPath *)complementIndexPath;

@end
