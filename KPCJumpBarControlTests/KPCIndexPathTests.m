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

- (void)testAddingNilToEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    NSIndexPath *newIndexPath = [indexPath KPC_indexPathByAddingIndexPath:nil];
    XCTAssertEqualObjects(indexPath, newIndexPath);
}

- (void)testAddingNilToValidIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    NSIndexPath *newIndexPath = [indexPath KPC_indexPathByAddingIndexPath:nil];
    XCTAssertEqualObjects(indexPath, newIndexPath);
}

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

# pragma mark - KPC_indexPathByAddingIndexInFront

- (void)testAddingIndexInFrontOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    NSIndexPath *newIndexPath = [indexPath KPC_indexPathByAddingIndexInFront:27];
    XCTAssertEqualObjects(newIndexPath, [NSIndexPath indexPathWithIndex:27]);
}

- (void)testAddingPositiveIndexInFrontOfValidIndexPath
{
    const NSUInteger indexes[] = { 34, 56, 78 };
    const NSUInteger finalIndexes[] = { 2, 34, 56, 78 };

    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:3];
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:4];

    XCTAssertEqualObjects([indexPath KPC_indexPathByAddingIndexInFront:2], finalIndexPath);
}

- (void)testAddingNegativeIndexInFrontOfValidIndexPath
{
    const NSUInteger indexes[] = { 34, -56, 78 };
    const NSUInteger finalIndexes[] = { -2, 34, -56, 78 };
    
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:3];
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:4];
    
    XCTAssertEqualObjects([indexPath KPC_indexPathByAddingIndexInFront:-2], finalIndexPath);
}


# pragma mark - KPC_subIndexPathFromPosition

- (void)testSubIndexPathFromPositionZeroOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathFromPosition:0]);
}

- (void)testSubIndexPathFromPositionOneOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathFromPosition:1]);
}

- (void)testSubIndexPathFromPositionTenOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathFromPosition:10]);
}



- (void)testSubIndexPathFromPositionZeroOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathFromPosition:0]);
}

- (void)testSubIndexPathFromPositionOneOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathFromPosition:1]);
}

- (void)testSubIndexPathFromPositionTenOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathFromPosition:10]);
}


- (void)testSubIndexPathFromPositionZeroOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathFromPosition:0]);
}

- (void)testSubIndexPathFromPositionOneOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    XCTAssertEqualObjects([NSIndexPath indexPathWithIndex:29], [indexPath KPC_subIndexPathFromPosition:1]);
}

- (void)testSubIndexPathFromPositionTwoOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathFromPosition:2]);
}

- (void)testSubIndexPathFromPositionTenOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathFromPosition:10]);
}


- (void)testSubIndexPathFromPositionZeroOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathFromPosition:0]);
}

- (void)testSubIndexPathFromPositionOneOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:8];
    
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathFromPosition:1]);
}

- (void)testSubIndexPathFromPositionTwoOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:7];
    
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathFromPosition:2]);
}

- (void)testSubIndexPathFromPositionHeightOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndex:99];

    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathFromPosition:8]);
}

- (void)testSubIndexPathFromPositionNineOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathFromPosition:9]);
}

- (void)testSubIndexPathFromPositionTenOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathFromPosition:10]);
}

@end
