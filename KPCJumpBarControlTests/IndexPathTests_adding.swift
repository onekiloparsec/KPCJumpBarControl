//
//  IndexPathTests_adding.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 09/05/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import XCTest
@testable import KPCJumpBarControl

class IndexPathTests_adding: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: - lastIndex
    
    func testLastIndexEmptyIndexPath() {
        let indexPath = NSIndexPath()
        XCTAssertTrue(indexPath.lastIndex() == NSNotFound)
    }
    
    func testLastIndexNullOneLevelIndexPath() {
        let indexPath = NSIndexPath(index:0)
        XCTAssertTrue(indexPath.lastIndex() == 0)
    }
    
    func testLastIndexNegativeOneLevelIndexPath() {
        let indexPath = NSIndexPath(index:-23)
        XCTAssertTrue(indexPath.lastIndex() == -23)
    }
    
    func testLastIndexPositiveOneLevelIndexPath() {
        let indexPath = NSIndexPath(index:42)
            XCTAssertTrue(indexPath.lastIndex() == 42)
    }
    
    func testLastIndexNullMultipleLevelIndexPath() {
        let indexPath = NSIndexPath(index:17).indexPathByAddingIndex(34).indexPathByAddingIndex(0)
            XCTAssertTrue(indexPath.lastIndex() == 0)
    }
    
    func testLastIndexNegativeMultipleLevelIndexPath() {
        let indexPath = NSIndexPath(index:17).indexPathByAddingIndex(34).indexPathByAddingIndex(-24)
        XCTAssertTrue(indexPath.lastIndex() == -24)
    }
    
    func testLastIndexPositiveMultipleLevelIndexPath() {
        let indexPath = NSIndexPath(index:17).indexPathByAddingIndex(34).indexPathByAddingIndex(43)
        XCTAssertTrue(indexPath.lastIndex() == 43)
    }
    
    
    // MARK: - indexPathByAddingIndexPath
    
    func testAddingNilToEmptyIndexPath() {
        let indexPath = NSIndexPath()
        let newIndexPath = indexPath.indexPathByAddingIndexPath(nil)
        XCTAssertEqual(indexPath, newIndexPath);
    }
    
    func testAddingNilToValidIndexPath() {
        let indexPath = NSIndexPath(index:42)
        let newIndexPath = indexPath.indexPathByAddingIndexPath(nil)
        XCTAssertEqual(indexPath, newIndexPath);
    }
    
    func testAddingEmptyIndexPathToEmptyIndexPath() {
        let indexPath = NSIndexPath()
        let newIndexPath = indexPath.indexPathByAddingIndexPath(NSIndexPath());
        XCTAssertEqual(indexPath, newIndexPath);
    }
    
    func testAddingEmptyIndexPathToValidIndexPath() {
        let indexPath = NSIndexPath(indexes: [2, 34, 56], length: 3);
        let newIndexPath = indexPath.indexPathByAddingIndexPath(NSIndexPath());
        XCTAssertEqual(indexPath, newIndexPath);
    }
    
    func testAddingValidIndexPathToEmptyIndexPath() {
        let indexPath = NSIndexPath(indexes: [2, 34, 56], length: 3);
        let newIndexPath = NSIndexPath().indexPathByAddingIndexPath(indexPath);
        XCTAssertEqual(indexPath, newIndexPath);
    }
    
    
    
    // MARK: - indexPathByAddingIndexInFront
    
    func testAddingIndexInFrontOfEmptyIndexPath() {
        let indexPath = NSIndexPath()
        let newIndexPath = indexPath.indexPathByAddingIndexInFront(27);
        XCTAssertEqual(newIndexPath, NSIndexPath(index:27));
    }
    
    func testAddingPositiveIndexInFrontOfValidIndexPath() {
        let indexPath = NSIndexPath(indexes:[34, 56, 78], length:3);
        let finalIndexPath = NSIndexPath(indexes:[2, 34, 56, 78], length:4);
        XCTAssertEqual(indexPath.indexPathByAddingIndexInFront(2), finalIndexPath);
    }
    
    func testAddingNegativeIndexInFrontOfValidIndexPath() {
        let indexPath = NSIndexPath(indexes:[34, -56, 78], length:3);
        let finalIndexPath = NSIndexPath(indexes:[-2, 34, -56, 78], length:4);
        XCTAssertEqual(indexPath.indexPathByAddingIndexInFront(-2), finalIndexPath);        
    }

}
