//
//  IndexPathTests_sub.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 09/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import KPCJumpBarControl

class IndexPathTests_sub: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSubIndexPathFromPositionZeroOfEmpty() {
        let indexPath = NSIndexPath()
        XCTAssertEqual(indexPath, indexPath.subIndexPathFromPosition(0))
    }
    
    func testSubIndexPathFromPositionOneOfEmpty() {
        let indexPath = NSIndexPath()
        XCTAssertEqual(indexPath, indexPath.subIndexPathFromPosition(1))
    }
    
    func testSubIndexPathFromPositionTenOfEmpty() {
        let indexPath = NSIndexPath()
        XCTAssertEqual(indexPath, indexPath.subIndexPathFromPosition(10))
    }
    

    // MARK: - KPC_subIndexPathFromPosition - Length One IndexPath
    
    func testSubIndexPathFromPositionZeroOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        XCTAssertEqual(indexPath, indexPath.subIndexPathFromPosition(0))
    }
    
    func testSubIndexPathFromPositionOneOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathFromPosition(1))
    }
    
    func testSubIndexPathFromPositionTenOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathFromPosition(10))
    }
    
    
    // MARK: - subIndexPathFromPosition - Length Two IndexPath
    
    func testSubIndexPathFromPositionZeroOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        XCTAssertEqual(indexPath, indexPath.subIndexPathFromPosition(0))
    }
    
    func testSubIndexPathFromPositionOneOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        XCTAssertEqual(NSIndexPath(index:29), indexPath.subIndexPathFromPosition(1))
    }
    
    func testSubIndexPathFromPositionTwoOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathFromPosition(2))
    }
    
    func testSubIndexPathFromPositionTenOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathFromPosition(10))
    }
    
    
    // MARK: - KPC_subIndexPathFromPosition - Length Nine IndexPath
    
    func testSubIndexPathFromPositionZeroOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        XCTAssertEqual(indexPath, indexPath.subIndexPathFromPosition(0))
    }
    
    func testSubIndexPathFromPositionOneOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[22, 33, 44, 55, 66, 77, 88, 99], length:8)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathFromPosition(1))
    }
    
    func testSubIndexPathFromPositionTwoOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[33, 44, 55, 66, 77, 88, 99], length:7)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathFromPosition(2))
    }
    
    func testSubIndexPathFromPositionHeightOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(index:99)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathFromPosition(8))
    }
    
    func testSubIndexPathFromPositionNineOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathFromPosition(9))
    }
    
    func testSubIndexPathFromPositionTenOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathFromPosition(10))
    }
    
    
    
    // MARK: - subIndexPathToPosition - Empty IndexPath
    
    func testSubIndexPathToPositionZeroOfEmpty() {
        let indexPath = NSIndexPath()
        XCTAssertEqual(indexPath, indexPath.subIndexPathToPosition(0))
    }
    
    func testSubIndexPathToPositionOneOfEmpty() {
        let indexPath = NSIndexPath()
        XCTAssertEqual(indexPath, indexPath.subIndexPathToPosition(1))
    }
    
    func testSubIndexPathToPositionTenOfEmpty() {
        let indexPath = NSIndexPath()
        XCTAssertEqual(indexPath, indexPath.subIndexPathToPosition(10))
    }
    
    
    // MARK: - KPC_subIndexPathToPosition - Length One IndexPath
    
    func testSubIndexPathToPositionZeroOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathToPosition(0))
    }
    
    func testSubIndexPathToPositionOneOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        XCTAssertEqual(indexPath, indexPath.subIndexPathToPosition(1))
    }
    
    func testSubIndexPathToPositionTenOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        XCTAssertEqual(indexPath, indexPath.subIndexPathToPosition(10))
    }
    
    
    // MARK: - KPC_subIndexPathToPosition - Length Two IndexPath
    
    func testSubIndexPathToPositionZeroOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathToPosition(0))
    }
    
    func testSubIndexPathToPositionOneOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        XCTAssertEqual(NSIndexPath(index:17), indexPath.subIndexPathToPosition(1))
    }
    
    func testSubIndexPathToPositionTwoOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        XCTAssertEqual(indexPath, indexPath.subIndexPathToPosition(2))
    }
    
    func testSubIndexPathToPositionTenOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        XCTAssertEqual(indexPath, indexPath.subIndexPathToPosition(10))
    }
    
    
    // MARK: - KPC_subIndexPathToPosition - Length Nine IndexPath
    
    func testSubIndexPathToPositionZeroOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathToPosition(0))
    }
    
    func testSubIndexPathToPositionOneOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        XCTAssertEqual(NSIndexPath(index:11), indexPath.subIndexPathToPosition(1))
    }
    
    func testSubIndexPathToPositionTwoOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[11, 22], length:2)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathToPosition(2))
    }
    
    func testSubIndexPathToPositionHeightOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88], length:8)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathToPosition(8))
    }
    
    func testSubIndexPathToPositionNineOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        XCTAssertEqual(indexPath, indexPath.subIndexPathToPosition(9))
    }
    
    func testSubIndexPathToPositionTenOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        XCTAssertEqual(indexPath, indexPath.subIndexPathToPosition(10))
    }
    
    
    
    
    // MARK: - KPC_subIndexPathWithRange - Empty Index Path
    
    func testSubIndexPathWithZeroRangeOfEmpty() {
        let indexPath = NSIndexPath()
        let r = NSMakeRange(0, 0)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithZeroLocValidLengthRangeOfEmpty() {
        let indexPath = NSIndexPath()
        let r = NSMakeRange(0, 10)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithValidLocValidLengthRangeOfEmpty() {
        let indexPath = NSIndexPath()
        let r = NSMakeRange(5, 10)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithZeroLocInvalidLengthRangeOfEmpty() {
        let indexPath = NSIndexPath()
        let r = NSMakeRange(0, NSNotFound)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithInvalidLocInvalidLengthRangeOfEmpty() {
        let indexPath = NSIndexPath()
        let r = NSMakeRange(NSNotFound, NSNotFound)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithInvalidLocZeroLengthRangeOfEmpty() {
        let indexPath = NSIndexPath()
        let r = NSMakeRange(NSNotFound, 0)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    
    // MARK: - KPC_subIndexPathWithRange - Length One IndexPath
    
    func testSubIndexPathWithZeroRangeOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        let r = NSMakeRange(0, 0)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithZeroLocValidLengthRangeOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        let r = NSMakeRange(0, 10)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithValidLocValidLengthRangeOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        let r = NSMakeRange(5, 10)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithZeroLocInvalidLengthRangeOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        let r = NSMakeRange(0, NSNotFound)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithInvalidLocInvalidLengthRangeOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        let r = NSMakeRange(NSNotFound, NSNotFound)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithInvalidLocZeroLengthRangeOfLengthOne() {
        let indexPath = NSIndexPath(index:42)
        let r = NSMakeRange(NSNotFound, 0)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    
    // MARK: - subIndexPathWithRange - Length Two IndexPath
    
    func testSubIndexPathWithZeroRangeOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        let r = NSMakeRange(0, 0)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithZeroLocValidLengthRangeOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        let r = NSMakeRange(0, 10)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithValidLocValidLengthRangeOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        let r = NSMakeRange(5, 10)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithZeroLocInvalidLengthRangeOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        let r = NSMakeRange(0, NSNotFound)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithInvalidLocInvalidLengthRangeOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        let r = NSMakeRange(NSNotFound, NSNotFound)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithInvalidLocZeroLengthRangeOfLengthTwo() {
        let indexPath = NSIndexPath(indexes:[17, 29], length:2)
        let r = NSMakeRange(NSNotFound, 0)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    
    // MARK: - KPC_subIndexPathWithRange - Length Nine IndexPath - Invalid
    
    func testSubIndexPathWithZeroRangeOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99 ], length:9)
        let r = NSMakeRange(0, 0)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithZeroLocValidLengthRangeOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99 ], length:9)
        let r = NSMakeRange(0, 10)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithZeroLocInvalidLengthRangeOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99 ], length:9)
        let r = NSMakeRange(0, NSNotFound)
        XCTAssertEqual(indexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithInvalidLocInvalidLengthRangeOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99 ], length:9)
        let r = NSMakeRange(NSNotFound, NSNotFound)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithInvalidLocZeroLengthRangeOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99 ], length:9)
        let r = NSMakeRange(NSNotFound, 0)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    
    // MARK: - subIndexPathWithRange - Length Nine IndexPath - Valid - Start
    
    func testSubIndexPathWithValidRangeAtStartLengthOneOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[11], length:1)
        let r = NSMakeRange(0, 1)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithValidRangeAtStartLengthFiveOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55], length:5)
        let r = NSMakeRange(0, 5)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithValidRangeAtStartLengthNineOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let r = NSMakeRange(0, 9)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithValidRangeAtStartLengthTenOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let r = NSMakeRange(0, 10)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathWithRange(r))
    }
    
    
    // MARK: - KPC_subIndexPathWithRange - Length Nine IndexPath - Valid - Middle
    
    func testSubIndexPathWithValidRangeAtMiddleLengthOneOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[55], length:1)
        let r = NSMakeRange(4, 1)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithValidRangeAtMiddleLengthFiveOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[55, 66, 77, 88, 99], length:5)
        let r = NSMakeRange(4, 5)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithValidRangeAtMiddleLengthNineOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[55, 66, 77, 88, 99], length:5)
        let r = NSMakeRange(4, 9)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathWithRange(r))
    }
    
    
    // MARK: - subIndexPathWithRange - Length Nine IndexPath - Valid - End
    
    func testSubIndexPathWithValidRangeAtEndLengthOneOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[99], length:1)
        let r = NSMakeRange(8, 1)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithValidRangeAtEndLengthOneAgainOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let r = NSMakeRange(9, 1)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithValidRangeAtEndLengthFiveOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let finalIndexPath = NSIndexPath(indexes:[99], length:1)
        let r = NSMakeRange(8, 5)
        XCTAssertEqual(finalIndexPath, indexPath.subIndexPathWithRange(r))
    }
    
    func testSubIndexPathWithValidRangeAtEndLengthFiveAgainAgainOfLengthNine() {
        let indexPath = NSIndexPath(indexes:[11, 22, 33, 44, 55, 66, 77, 88, 99], length:9)
        let r = NSMakeRange(9, 5)
        XCTAssertEqual(NSIndexPath(), indexPath.subIndexPathWithRange(r))
    }

}
