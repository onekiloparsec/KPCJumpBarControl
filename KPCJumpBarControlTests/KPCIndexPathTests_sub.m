//
//  KPCIndexPathTests.m
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 02/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSIndexPath+KPCUtils.h"

@interface KPCIndexPathTests_sub : XCTestCase

@end

@implementation KPCIndexPathTests_sub

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

# pragma mark - KPC_subIndexPathFromPosition - Empty IndexPath

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


# pragma mark - KPC_subIndexPathFromPosition - Length One IndexPath

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


# pragma mark - KPC_subIndexPathFromPosition - Length Two IndexPath

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


# pragma mark - KPC_subIndexPathFromPosition - Length Nine IndexPath

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



# pragma mark - KPC_subIndexPathToPosition - Empty IndexPath

- (void)testSubIndexPathToPositionZeroOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathToPosition:0]);
}

- (void)testSubIndexPathToPositionOneOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathToPosition:1]);
}

- (void)testSubIndexPathToPositionTenOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathToPosition:10]);
}


# pragma mark - KPC_subIndexPathToPosition - Length One IndexPath

- (void)testSubIndexPathToPositionZeroOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathToPosition:0]);
}

- (void)testSubIndexPathToPositionOneOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathToPosition:1]);
}

- (void)testSubIndexPathToPositionTenOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathToPosition:10]);
}


# pragma mark - KPC_subIndexPathToPosition - Length Two IndexPath

- (void)testSubIndexPathToPositionZeroOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathToPosition:0]);
}

- (void)testSubIndexPathToPositionOneOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    XCTAssertEqualObjects([NSIndexPath indexPathWithIndex:17], [indexPath KPC_subIndexPathToPosition:1]);
}

- (void)testSubIndexPathToPositionTwoOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathToPosition:2]);
}

- (void)testSubIndexPathToPositionTenOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathToPosition:10]);
}


# pragma mark - KPC_subIndexPathToPosition - Length Nine IndexPath

- (void)testSubIndexPathToPositionZeroOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathToPosition:0]);
}

- (void)testSubIndexPathToPositionOneOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    XCTAssertEqualObjects([NSIndexPath indexPathWithIndex:11], [indexPath KPC_subIndexPathToPosition:1]);
}

- (void)testSubIndexPathToPositionTwoOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 11, 22 };
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:2];
    
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathToPosition:2]);
}

- (void)testSubIndexPathToPositionHeightOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 11, 22, 33, 44, 55, 66, 77, 88 };
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:8];
    
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathToPosition:8]);
}

- (void)testSubIndexPathToPositionNineOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathToPosition:9]);
}

- (void)testSubIndexPathToPositionTenOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathToPosition:10]);
}




# pragma mark - KPC_subIndexPathWithRange - Empty Index Path

- (void)testSubIndexPathWithZeroRangeOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    NSRange r = NSMakeRange(0, 0);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithZeroLocValidLengthRangeOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    NSRange r = NSMakeRange(0, 10);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithValidLocValidLengthRangeOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    NSRange r = NSMakeRange(5, 10);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithZeroLocInvalidLengthRangeOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    NSRange r = NSMakeRange(0, NSNotFound);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithInvalidLocInvalidLengthRangeOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    NSRange r = NSMakeRange(NSNotFound, NSNotFound);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithInvalidLocZeroLengthRangeOfEmptyIndexPath
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    NSRange r = NSMakeRange(NSNotFound, 0);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}


# pragma mark - KPC_subIndexPathWithRange - Length One IndexPath

- (void)testSubIndexPathWithZeroRangeOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    NSRange r = NSMakeRange(0, 0);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithZeroLocValidLengthRangeOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    NSRange r = NSMakeRange(0, 10);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithValidLocValidLengthRangeOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    NSRange r = NSMakeRange(5, 10);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithZeroLocInvalidLengthRangeOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    NSRange r = NSMakeRange(0, NSNotFound);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithInvalidLocInvalidLengthRangeOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    NSRange r = NSMakeRange(NSNotFound, NSNotFound);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithInvalidLocZeroLengthRangeOfLengthOneIndexPath
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:42];
    NSRange r = NSMakeRange(NSNotFound, 0);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}


# pragma mark - KPC_subIndexPathWithRange - Length Two IndexPath

- (void)testSubIndexPathWithZeroRangeOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    NSRange r = NSMakeRange(0, 0);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithZeroLocValidLengthRangeOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    NSRange r = NSMakeRange(0, 10);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithValidLocValidLengthRangeOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    NSRange r = NSMakeRange(5, 10);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithZeroLocInvalidLengthRangeOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    NSRange r = NSMakeRange(0, NSNotFound);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithInvalidLocInvalidLengthRangeOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    NSRange r = NSMakeRange(NSNotFound, NSNotFound);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithInvalidLocZeroLengthRangeOfLengthTwoIndexPath
{
    const NSUInteger indexes[] = { 17, 29, };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    NSRange r = NSMakeRange(NSNotFound, 0);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}


# pragma mark - KPC_subIndexPathWithRange - Length Nine IndexPath - Invalid

- (void)testSubIndexPathWithZeroRangeOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    NSRange r = NSMakeRange(0, 0);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithZeroLocValidLengthRangeOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    NSRange r = NSMakeRange(0, 10);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithZeroLocInvalidLengthRangeOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    NSRange r = NSMakeRange(0, NSNotFound);
    XCTAssertEqualObjects(indexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithInvalidLocInvalidLengthRangeOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    NSRange r = NSMakeRange(NSNotFound, NSNotFound);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithInvalidLocZeroLengthRangeOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    NSRange r = NSMakeRange(NSNotFound, 0);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}


# pragma mark - KPC_subIndexPathWithRange - Length Nine IndexPath - Valid - Start

- (void)testSubIndexPathWithValidRangeAtStartLengthOneOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 11, };
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:1];
    
    NSRange r = NSMakeRange(0, 1);
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithValidRangeAtStartLengthFiveOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 11, 22, 33, 44, 55};
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:5];
    
    NSRange r = NSMakeRange(0, 5);
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithValidRangeAtStartLengthNineOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:9];
    
    NSRange r = NSMakeRange(0, 9);
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithValidRangeAtStartLengthTenOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:9];
    
    NSRange r = NSMakeRange(0, 10);
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathWithRange:r]);
}


# pragma mark - KPC_subIndexPathWithRange - Length Nine IndexPath - Valid - Middle

- (void)testSubIndexPathWithValidRangeAtMiddleLengthOneOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 55, };
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:1];
    
    NSRange r = NSMakeRange(4, 1);
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithValidRangeAtMiddleLengthFiveOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 55, 66, 77, 88, 99};
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:5];
    
    NSRange r = NSMakeRange(4, 5);
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithValidRangeAtMiddleLengthNineOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 55, 66, 77, 88, 99 };
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:5];
    
    NSRange r = NSMakeRange(4, 9);
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathWithRange:r]);
}


# pragma mark - KPC_subIndexPathWithRange - Length Nine IndexPath - Valid - End

- (void)testSubIndexPathWithValidRangeAtEndLengthOneOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 99, };
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:1];
    
    NSRange r = NSMakeRange(8, 1);
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithValidRangeAtEndLengthOneAgainOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    NSRange r = NSMakeRange(9, 1);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithValidRangeAtEndLengthFiveOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    const NSUInteger finalIndexes[] = { 99, };
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathWithIndexes:finalIndexes length:1];

    NSRange r = NSMakeRange(8, 5);
    XCTAssertEqualObjects(finalIndexPath, [indexPath KPC_subIndexPathWithRange:r]);
}

- (void)testSubIndexPathWithValidRangeAtEndLengthFiveAgainAgainOfLengthNineIndexPath
{
    const NSUInteger indexes[] = { 11, 22, 33, 44, 55, 66, 77, 88, 99 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:9];
    
    NSRange r = NSMakeRange(9, 5);
    XCTAssertEqualObjects([[NSIndexPath alloc] init], [indexPath KPC_subIndexPathWithRange:r]);
}

@end
