//
//  IndexPathTests_replacing.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 09/05/16.
//  Licensed under the MIT License (see LICENSE file)
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
        let indexPath = IndexPath()
        XCTAssertEqual(indexPath, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:0))
        XCTAssertEqual(indexPath, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:-12))
        XCTAssertEqual(indexPath, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:+27))
    }
    
    func testIndexPathByReplacingIndexZeroOfLengthOneIndexPath() {
        let indexPath = IndexPath(index:99)
        XCTAssertEqual(IndexPath(index:0), indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:0))
        XCTAssertEqual(IndexPath(index:-12), indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:-12))
        XCTAssertEqual(IndexPath(index:27), indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:+27))
    }
    
    func testIndexPathByReplacingIndexZeroOfLengthTwoIndexPath() {
        let indexPath = IndexPath(indexes:[99, 999], length:2)
    
        let finalIndexPath1 = IndexPath(index:0).indexPathByAddingIndex(999)
        let finalIndexPath2 = IndexPath(index:-12).indexPathByAddingIndex(999)
        let finalIndexPath3 = IndexPath(index:+27).indexPathByAddingIndex(999)
    
        XCTAssertEqual(finalIndexPath1, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:0))
        XCTAssertEqual(finalIndexPath2, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:-12))
        XCTAssertEqual(finalIndexPath3, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:+27))
    }
    
    func testIndexPathByReplacingIndexOneOfLengthTwoIndexPath() {
        let indexPath = IndexPath(indexes:[ 99, 999], length:2)
    
        let finalIndexPath1 = IndexPath(index:99).indexPathByAddingIndex(0)
        let finalIndexPath2 = IndexPath(index:99).indexPathByAddingIndex(-12)
        let finalIndexPath3 = IndexPath(index:99).indexPathByAddingIndex(+27)
    
        XCTAssertEqual(finalIndexPath1, indexPath.indexPathByReplacingIndexAtPosition(1, withIndex:0))
        XCTAssertEqual(finalIndexPath2, indexPath.indexPathByReplacingIndexAtPosition(1, withIndex:-12))
        XCTAssertEqual(finalIndexPath3, indexPath.indexPathByReplacingIndexAtPosition(1, withIndex:+27))
    }
    
    
    // MARK: - Nine
    
    func testIndexPathByReplacingIndexZeroOfLengthNineIndexPath() {
        let indexPath = IndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath1 = IndexPath(indexes:[0, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath2 = IndexPath(indexes:[-12, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath3 = IndexPath(indexes:[27, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
    
        XCTAssertEqual(finalIndexPath1, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:0))
        XCTAssertEqual(finalIndexPath2, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:-12))
        XCTAssertEqual(finalIndexPath3, indexPath.indexPathByReplacingIndexAtPosition(0, withIndex:+27))
    }
    
    func testIndexPathByReplacingIndexFourOfLengthNineIndexPath() {
        let indexPath = IndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath1 = IndexPath(indexes:[11, 22, 33, 44, 0, 66, 77, 88, 99], length:9)
        let finalIndexPath2 = IndexPath(indexes:[11, 22, 33, 44, -12, 66, 77, 88, 99], length:9)
        let finalIndexPath3 = IndexPath(indexes:[11, 22, 33, 44, +27, 66, 77, 88, 99], length:9)
    
        XCTAssertEqual(finalIndexPath1, indexPath.indexPathByReplacingIndexAtPosition(4, withIndex:0))
        XCTAssertEqual(finalIndexPath2, indexPath.indexPathByReplacingIndexAtPosition(4, withIndex:-12))
        XCTAssertEqual(finalIndexPath3, indexPath.indexPathByReplacingIndexAtPosition(4, withIndex:+27))
    }
    
    func testIndexPathByReplacingIndexHeightOfLengthNineIndexPath() {
        let indexPath = IndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath1 = IndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 0 ], length:9)
        let finalIndexPath2 = IndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, -12], length:9)
        let finalIndexPath3 = IndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, +27], length:9)
    
        XCTAssertEqual(finalIndexPath1, indexPath.indexPathByReplacingIndexAtPosition(8, withIndex:0))
        XCTAssertEqual(finalIndexPath2, indexPath.indexPathByReplacingIndexAtPosition(8, withIndex:-12))
        XCTAssertEqual(finalIndexPath3, indexPath.indexPathByReplacingIndexAtPosition(8, withIndex:+27))
    }
    
    
    // MARK: - indexPathByIncrementingLastIndex
    
    func testIndexPathIncrementingLastIndexOfEmptyIndexPath() {
        let indexPath = IndexPath()
        XCTAssertEqual(indexPath, indexPath.indexPathByIncrementingLastIndex())
    }
    
    func testIndexPathIncrementingLastIndexOfLengthOneIndexPath() {
        let indexPath = IndexPath(index:99)
        XCTAssertEqual(IndexPath(index:100), indexPath.indexPathByIncrementingLastIndex())
    }
    
    func testIndexPathIncrementingLastIndexOfLengthTwoIndexPath() {
        let indexPath = IndexPath(index:77).indexPathByAddingIndex(99)
        let finalIndexPath = IndexPath(index:77).indexPathByAddingIndex(100)
        XCTAssertEqual(finalIndexPath, indexPath.indexPathByIncrementingLastIndex())
    }
    
}
