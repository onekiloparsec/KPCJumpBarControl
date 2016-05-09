//
//  KPCIndexPathTests.m
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 02/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface KPCIndexPathTests_adding : XCTestCase

@end

@implementation KPCIndexPathTests_adding

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

# pragma mark - lastIndex

- (void)testLastIndexEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    XCTAssertTrue([indexPath lastIndex] == NSNotFound);
}

- (void)testLastIndexNullOneLevelIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:0];
    XCTAssertTrue([indexPath lastIndex] == 0);
}

- (void)testLastIndexNegativeOneLevelIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:-23];
    XCTAssertTrue([indexPath lastIndex] == -23);
}

- (void)testLastIndexPositiveOneLevelIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    XCTAssertTrue([indexPath lastIndex] == 42);
}

- (void)testLastIndexNullMultipleLevelIndexPath
{
    NSIndexPath *indexPath = [[[NSIndexPath indexPathWithIndex:17] indexPathByAddingIndex:34] indexPathByAddingIndex:0];
    XCTAssertTrue([indexPath lastIndex] == 0);
}

- (void)testLastIndexNegativeMultipleLevelIndexPath
{
    NSIndexPath *indexPath = [[[NSIndexPath indexPathWithIndex:17] indexPathByAddingIndex:34] indexPathByAddingIndex:-24];
    XCTAssertTrue([indexPath lastIndex] == -24);
}

- (void)testLastIndexPositiveMultipleLevelIndexPath
{
    NSIndexPath *indexPath = [[[NSIndexPath indexPathWithIndex:17] indexPathByAddingIndex:34] indexPathByAddingIndex:43];
    XCTAssertTrue([indexPath lastIndex] == 43);
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



@end
