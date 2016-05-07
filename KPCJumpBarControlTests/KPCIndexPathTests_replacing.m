//
//  KPCIndexPathTests.m
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 02/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSIndexPath+KPCUtils.h"

@interface KPCIndexPathTests_replacing : XCTestCase

@end

@implementation KPCIndexPathTests_replacing

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

# pragma mark - KPC_indexPathByReplacingIndexAtPosition

- (void)testIndexPathByReplacingIndexZeroOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:0]);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:-12]);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:+27]);
}

- (void)testIndexPathByReplacingIndexZeroOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:99];
    XCTAssertEqualObjects([NSIndexPath indexPathWithIndex:0], [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:0]);
    XCTAssertEqualObjects([NSIndexPath indexPathWithIndex:-12], [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:-12]);
    XCTAssertEqualObjects([NSIndexPath indexPathWithIndex:27], [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:+27]);
}

- (void)testIndexPathByReplacingIndexZeroOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 99, 999 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];

    NSIndexPath *finalIndexPath1 = [[NSIndexPath indexPathWithIndex:0] indexPathByAddingIndex:999];
    NSIndexPath *finalIndexPath2 = [[NSIndexPath indexPathWithIndex:-12] indexPathByAddingIndex:999];
    NSIndexPath *finalIndexPath3 = [[NSIndexPath indexPathWithIndex:+27] indexPathByAddingIndex:999];

    XCTAssertEqualObjects(finalIndexPath1, [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:0]);
    XCTAssertEqualObjects(finalIndexPath2, [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:-12]);
    XCTAssertEqualObjects(finalIndexPath3, [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:+27]);
}

- (void)testIndexPathByReplacingIndexOneOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 99, 999 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    
    NSIndexPath *finalIndexPath1 = [[NSIndexPath indexPathWithIndex:99] indexPathByAddingIndex:0];
    NSIndexPath *finalIndexPath2 = [[NSIndexPath indexPathWithIndex:99] indexPathByAddingIndex:-12];
    NSIndexPath *finalIndexPath3 = [[NSIndexPath indexPathWithIndex:99] indexPathByAddingIndex:+27];
    
    XCTAssertEqualObjects(finalIndexPath1, [indexPath KPC_indexPathByReplacingIndexAtPosition:1 withIndex:0]);
    XCTAssertEqualObjects(finalIndexPath2, [indexPath KPC_indexPathByReplacingIndexAtPosition:1 withIndex:-12]);
    XCTAssertEqualObjects(finalIndexPath3, [indexPath KPC_indexPathByReplacingIndexAtPosition:1 withIndex:+27]);
}

# pragma mark - Nine

- (void)testIndexPathByReplacingIndexZeroOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes1[] = { 0, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *finalIndexPath1 = [NSIndexPath indexPathWithIndexes:finalIndexes1 length:9];

    const NSUInteger finalIndexes2[] = { -12, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *finalIndexPath2 = [NSIndexPath indexPathWithIndexes:finalIndexes2 length:9];

    const NSUInteger finalIndexes3[] = { 27, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *finalIndexPath3 = [NSIndexPath indexPathWithIndexes:finalIndexes3 length:9];
    
    XCTAssertEqualObjects(finalIndexPath1, [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:0]);
    XCTAssertEqualObjects(finalIndexPath2, [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:-12]);
    XCTAssertEqualObjects(finalIndexPath3, [indexPath KPC_indexPathByReplacingIndexAtPosition:0 withIndex:+27]);
}

- (void)testIndexPathByReplacingIndexFourOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes1[] = { 11, 22, 33, 44, 0, 66, 77, 88, 99 };
    NSIndexPath *finalIndexPath1 = [NSIndexPath indexPathWithIndexes:finalIndexes1 length:9];
    
    const NSUInteger finalIndexes2[] = { 11, 22, 33, 44, -12, 66, 77, 88, 99 };
    NSIndexPath *finalIndexPath2 = [NSIndexPath indexPathWithIndexes:finalIndexes2 length:9];
    
    const NSUInteger finalIndexes3[] = { 11, 22, 33, 44, +27, 66, 77, 88, 99 };
    NSIndexPath *finalIndexPath3 = [NSIndexPath indexPathWithIndexes:finalIndexes3 length:9];
    
    XCTAssertEqualObjects(finalIndexPath1, [indexPath KPC_indexPathByReplacingIndexAtPosition:4 withIndex:0]);
    XCTAssertEqualObjects(finalIndexPath2, [indexPath KPC_indexPathByReplacingIndexAtPosition:4 withIndex:-12]);
    XCTAssertEqualObjects(finalIndexPath3, [indexPath KPC_indexPathByReplacingIndexAtPosition:4 withIndex:+27]);
}

- (void)testIndexPathByReplacingIndexHeightOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes1[] = { 11, 22, 33, 44, 55, 66, 77, 88, 0 };
    NSIndexPath *finalIndexPath1 = [NSIndexPath indexPathWithIndexes:finalIndexes1 length:9];
    
    const NSUInteger finalIndexes2[] = { 11, 22, 33, 44, 55, 66, 77, 88, -12 };
    NSIndexPath *finalIndexPath2 = [NSIndexPath indexPathWithIndexes:finalIndexes2 length:9];
    
    const NSUInteger finalIndexes3[] = { 11, 22, 33, 44, 55, 66, 77, 88, +27 };
    NSIndexPath *finalIndexPath3 = [NSIndexPath indexPathWithIndexes:finalIndexes3 length:9];
    
    XCTAssertEqualObjects(finalIndexPath1, [indexPath KPC_indexPathByReplacingIndexAtPosition:8 withIndex:0]);
    XCTAssertEqualObjects(finalIndexPath2, [indexPath KPC_indexPathByReplacingIndexAtPosition:8 withIndex:-12]);
    XCTAssertEqualObjects(finalIndexPath3, [indexPath KPC_indexPathByReplacingIndexAtPosition:8 withIndex:+27]);
}


# pragma mark - KPC_indexPathByIncrementingLastIndex

- (void)testIndexPathIncrementingLastIndexOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_indexPathByIncrementingLastIndex]);
}

- (void)testIndexPathIncrementingLastIndexOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:99];
    XCTAssertEqualObjects([NSIndexPath indexPathWithIndex:100], [indexPath KPC_indexPathByIncrementingLastIndex]);
}

- (void)testIndexPathIncrementingLastIndexOfLengthTwoIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath indexPathWithIndex:77] indexPathByAddingIndex:99];
    NSIndexPath *finalIndexPath = [[NSIndexPath indexPathWithIndex:77] indexPathByAddingIndex:100];
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_indexPathByIncrementingLastIndex]);
}

@end
