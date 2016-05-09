//
//  IndexPathTests_replacing.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 09/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import KPCJumpBarControl

class IndexPathTests_replacing: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testIndexPathByReplacingIndexZeroOfEmptyIndexPath() {
        let indexPath = NSIndexPath()
        XCTAssertEqual(indexPath, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:0))
        XCTAssertEqual(indexPath, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:-12))
        XCTAssertEqual(indexPath, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:+27))
    }
    
    func testIndexPathByReplacingIndexZeroOfLengthOneIndexPath() {
        let indexPath = NSIndexPath(index:99)
        XCTAssertEqual(NSIndexPath(index:0), indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:0))
        XCTAssertEqual(NSIndexPath(index:-12), indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:-12))
        XCTAssertEqual(NSIndexPath(index:27), indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:+27))
    }
    
    func testIndexPathByReplacingIndexZeroOfLengthTwoIndexPath() {
        let indexPath = NSIndexPath(indexes:[99, 999], length:2)
    
        let finalIndexPath1 = NSIndexPath(index:0).indexPathByAddingIndex(999)
        let finalIndexPath2 = NSIndexPath(index:-12).indexPathByAddingIndex(999)
        let finalIndexPath3 = NSIndexPath(index:+27).indexPathByAddingIndex(999)
    
        XCTAssertEqual(finalIndexPath1, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:0))
        XCTAssertEqual(finalIndexPath2, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:-12))
        XCTAssertEqual(finalIndexPath3, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:+27))
    }
    
    func testIndexPathByReplacingIndexOneOfLengthTwoIndexPath() {
        let indexPath = NSIndexPath(indexes:[ 99, 999], length:2)
    
        let finalIndexPath1 = NSIndexPath(index:99).indexPathByAddingIndex(0)
        let finalIndexPath2 = NSIndexPath(index:99).indexPathByAddingIndex(-12)
        let finalIndexPath3 = NSIndexPath(index:99).indexPathByAddingIndex(+27)
    
        XCTAssertEqual(finalIndexPath1, indexPath.indexPathByReplacingIndexAtPosition(1, withIndex:0))
        XCTAssertEqual(finalIndexPath2, indexPath.indexPathByReplacingIndexAtPosition(1, withIndex:-12))
        XCTAssertEqual(finalIndexPath3, indexPath.indexPathByReplacingIndexAtPosition(1, withIndex:+27))
    }
    
    
    // MARK: - Nine
    
    func testIndexPathByReplacingIndexZeroOfLengthNineIndexPath() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath1 = NSIndexPath(indexes:[0, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath2 = NSIndexPath(indexes:[-12, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath3 = NSIndexPath(indexes:[27, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
    
        XCTAssertEqual(finalIndexPath1, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:0))
        XCTAssertEqual(finalIndexPath2, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:-12))
        XCTAssertEqual(finalIndexPath3, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:+27))
    }
    
    func testIndexPathByReplacingIndexFourOfLengthNineIndexPath() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath1 = NSIndexPath(indexes:[11, 22, 33, 44, 0, 66, 77, 88, 99], length:9)
        let finalIndexPath2 = NSIndexPath(indexes:[11, 22, 33, 44, -12, 66, 77, 88, 99], length:9)
        let finalIndexPath3 = NSIndexPath(indexes:[11, 22, 33, 44, +27, 66, 77, 88, 99], length:9)
    
        XCTAssertEqual(finalIndexPath1, indexPath.indexPathByReplacingIndexAtPosition(4, withIndex:0))
        XCTAssertEqual(finalIndexPath2, indexPath.indexPathByReplacingIndexAtPosition(4, withIndex:-12))
        XCTAssertEqual(finalIndexPath3, indexPath.indexPathByReplacingIndexAtPosition(4, withIndex:+27))
    }
    
    func testIndexPathByReplacingIndexHeightOfLengthNineIndexPath() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath1 = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 0 ], length:9)
        let finalIndexPath2 = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, -12], length:9)
        let finalIndexPath3 = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, +27], length:9)
    
        XCTAssertEqual(finalIndexPath1, indexPath.indexPathByReplacingIndexAtPosition(8, withIndex:0))
        XCTAssertEqual(finalIndexPath2, indexPath.indexPathByReplacingIndexAtPosition(8, withIndex:-12))
        XCTAssertEqual(finalIndexPath3, indexPath.indexPathByReplacingIndexAtPosition(8, withIndex:+27))
    }
    
    
    // MARK: - indexPathByIncrementingLastIndex
    
    func testIndexPathIncrementingLastIndexOfEmptyIndexPath() {
        let indexPath = NSIndexPath()
        XCTAssertEqual(indexPath, indexPath.indexPathByIncrementingLastIndex())
    }
    
    func testIndexPathIncrementingLastIndexOfLengthOneIndexPath() {
        let indexPath = NSIndexPath(index:99)
        XCTAssertEqual(NSIndexPath(index:100), indexPath.indexPathByIncrementingLastIndex())
    }
    
    func testIndexPathIncrementingLastIndexOfLengthTwoIndexPath() {
        let indexPath = NSIndexPath(index:77).indexPathByAddingIndex(99)
        let finalIndexPath = NSIndexPath(index:77).indexPathByAddingIndex(100)
        XCTAssertEqual(finalIndexPath, indexPath.indexPathByIncrementingLastIndex())
    }
    
}
