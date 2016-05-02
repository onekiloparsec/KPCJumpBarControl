//
//  KPCIndexPathTests.m
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 02/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSIndexPath+KPCUtils.h"

@interface KPCIndexPathTests : XCTestCase

@end

@implementation KPCIndexPathTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

# pragma mark - KPC_lastIndex

- (void)testLastIndexEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    XCTAssertTrue([indexPath KPC_lastIndex] == NSNotFound);
}

- (void)testLastIndexNullOneLevelIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:0];
    XCTAssertTrue([indexPath KPC_lastIndex] == 0);
}

- (void)testLastIndexNegativeOneLevelIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:-23];
    XCTAssertTrue([indexPath KPC_lastIndex] == -23);
}

- (void)testLastIndexPositiveOneLevelIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    XCTAssertTrue([indexPath KPC_lastIndex] == 42);
}

- (void)testLastIndexNullMultipleLevelIndexPath
{
    NSIndexPath *indexPath = [[[NSIndexPath indexPathWithIndex:17] indexPathByAddingIndex:34] indexPathByAddingIndex:0];
    XCTAssertTrue([indexPath KPC_lastIndex] == 0);
}

- (void)testLastIndexNegativeMultipleLevelIndexPath
{
    NSIndexPath *indexPath = [[[NSIndexPath indexPathWithIndex:17] indexPathByAddingIndex:34] indexPathByAddingIndex:-24];
    XCTAssertTrue([indexPath KPC_lastIndex] == -24);
}

- (void)testLastIndexPositiveMultipleLevelIndexPath
{
    NSIndexPath *indexPath = [[[NSIndexPath indexPathWithIndex:17] indexPathByAddingIndex:34] indexPathByAddingIndex:43];
    XCTAssertTrue([indexPath KPC_lastIndex] == 43);
}

# pragma mark - KPC_indexPathByAddingIndexPath

- (void)testAddingEmptyIndexPathToEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    NSIndexPath *newIndexPath = [indexPath KPC_indexPathByAddingIndexPath:[[NSIndexPath alloc] init]];
    XCTAssertEqualObjects(indexPath, newIndexPath);
}

- (void)testAddingEmptyIndexPathToValidIndexPath
{
    const NSUInteger indexes[] = { 2, 34, 56 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:3];
    NSIndexPath *newIndexPath = [indexPath KPC_indexPathByAddingIndexPath:[[NSIndexPath alloc] init]];
    XCTAssertEqualObjects(indexPath, newIndexPath);
}

- (void)testAddingValidIndexPathToEmptyIndexPath
{
    const NSUInteger indexes[] = { 2, 34, 56 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:3];
    NSIndexPath *newIndexPath = [[[NSIndexPath alloc] init] KPC_indexPathByAddingIndexPath:indexPath];
    XCTAssertEqualObjects(indexPath, newIndexPath);
}

@end
