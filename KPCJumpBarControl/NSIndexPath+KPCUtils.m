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

- (NSIndexPath *)KPC_indexPathByAddingIndexInFront:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:index];
    return [indexPath KPC_indexPathByAddingIndexPath:self];
}

- (NSIndexPath *)KPC_subIndexPathFromPosition:(NSUInteger)position
{
    if (position > self.length-1 || self.length == 0) {
        return [[NSIndexPath alloc] init];
    }
    return [self KPC_subIndexPathWithRange:NSMakeRange(position, self.length - position)];
}

- (NSIndexPath *)KPC_subIndexPathToPosition:(NSUInteger)position
{
    if (position < 1 || self.length == 0) {
        return [[NSIndexPath alloc] init];
    }
    return [self KPC_subIndexPathWithRange:NSMakeRange(0, position)];
}

- (NSIndexPath *)KPC_subIndexPathWithRange:(NSRange)range
{
    if (range.location > self.length-1 || self.length == 0 || NSMaxRange(range) == 0) {
        return [[NSIndexPath alloc] init];
    }
    
    NSUInteger end = MIN(NSMaxRange(range), self.length); // Use length, and not length-1 because of strictly "<"end below.
    
    NSIndexPath *path = [[NSIndexPath alloc] init];
    for (NSUInteger position = range.location; position < end ; position ++) {
        path = [path indexPathByAddingIndex:[self indexAtPosition:position]];
    }
    
    return path;
}

- (NSIndexPath *)KPC_indexPathByReplacingIndexAtPosition:(NSUInteger)position withIndex:(NSInteger)index
{
    if (self.length == 0) {
        return [[NSIndexPath alloc] init];
    }
    else if (position == 0) {
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

- (NSIndexPath *)KPC_indexPathByReplacingLastIndexWithIndex:(NSInteger)index
{
    return [self KPC_indexPathByReplacingIndexAtPosition:[self length]-1 withIndex:index];
}

- (NSIndexPath *)KPC_indexPathByIncrementingLastIndex
{
    NSInteger lastIndex = [self indexAtPosition:[self length]-1];
    return [self KPC_indexPathByReplacingIndexAtPosition:[self length]-1 withIndex:lastIndex+1];
}

- (NSString *)KPC_stringValue
{
    NSMutableString *reprensentation = [[NSMutableString alloc] initWithCapacity:[self length] * 2 - 1];
    [reprensentation appendFormat:@"%ld", [self indexAtPosition:0]];
    
    for (NSUInteger position = 1; position < self.length ; position ++) {
        [reprensentation appendFormat:@".%ld", [self indexAtPosition:position]];
    }
    
    return reprensentation;
}

@end
