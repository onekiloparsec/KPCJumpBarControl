//
//  NSIndexPath+KPCUtils.m
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 01/05/16.
//  Licensed under the MIT License (see LICENSE file)
//

#import "NSIndexPath+KPCUtils.h"

@implementation NSIndexPath (KPCUtils)

- (NSInteger)KPC_lastIndex
{
    return [self indexAtPosition:[self length]-1];
}

- (NSIndexPath *)KPC_indexPathByAddingIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *path = [self copy];
    for (NSUInteger position = 0; position < indexPath.length ; position ++) {
        path = [path indexPathByAddingIndex:[indexPath indexAtPosition:position]];
    }
    return path;
}

- (NSIndexPath *)KPC_indexPathByAddingIndexInFront:(NSUInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:index];
    return [indexPath KPC_indexPathByAddingIndexPath:self];
}

- (NSIndexPath *)KPC_subIndexPathFromPosition:(NSUInteger)position
{
    return [self KPC_subIndexPathWithRange:NSMakeRange(position, self.length - position)];
}

- (NSIndexPath *)KPC_subIndexPathToPosition:(NSUInteger)position
{
    if (position == 0) {
        return [NSIndexPath indexPathWithIndex:[self indexAtPosition:0]];
    }
    return [self KPC_subIndexPathWithRange:NSMakeRange(0, position)];
}

- (NSIndexPath *)KPC_subIndexPathWithRange:(NSRange)range
{
    NSIndexPath *path = [[NSIndexPath alloc] init];
    for (NSUInteger position = range.location; position < (range.location + range.length) ; position ++) {
        path = [path indexPathByAddingIndex:[self indexAtPosition:position]];
    }
    return path;
}

- (NSIndexPath *)KPC_indexPathByReplacingIndexAtPosition:(NSUInteger)position withIndex:(NSUInteger)index
{
    if (position == 0) {
        NSIndexPath *trailIndexPath = [self KPC_subIndexPathFromPosition:position+1];
        return [[NSIndexPath indexPathWithIndex:index] KPC_indexPathByAddingIndexPath:trailIndexPath];
    }
    else if (position == [self length]-1) {
        NSIndexPath *frontIndexPath = [self KPC_subIndexPathToPosition:position];
        return [frontIndexPath indexPathByAddingIndex:index];
    }
    else {
        NSIndexPath *frontIndexPath = [self KPC_subIndexPathToPosition:position];
        NSIndexPath *trailIndexPath = [self KPC_subIndexPathFromPosition:position+1];
        return [[frontIndexPath indexPathByAddingIndex:index] KPC_indexPathByAddingIndexPath:trailIndexPath];
    }
}

- (NSIndexPath *)KPC_indexPathByReplacingLastIndexWithIndex:(NSUInteger)index
{
    return [self KPC_indexPathByReplacingIndexAtPosition:[self length]-1 withIndex:index];
}

- (NSIndexPath *)KPC_indexPathByIncrementingLastIndex
{
    NSInteger lastIndex = [self indexAtPosition:[self length]-1];
    return [self KPC_indexPathByReplacingIndexAtPosition:[self length]-1 withIndex:lastIndex+1];
}

- (NSIndexPath *)KPC_indexPathByFillingWithIndexPath:(NSIndexPath *)complementIndexPath
{
    NSAssert([self length] <= [complementIndexPath length], @"Index length is wrong.");
    NSIndexPath *cutIndexPath = [complementIndexPath KPC_subIndexPathToPosition:[self length]];
    return [self KPC_indexPathByAddingIndexPath:cutIndexPath];
}

@end
