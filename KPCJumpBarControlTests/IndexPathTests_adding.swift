//
//  IndexPathTests_adding.swift
//  KPCJumpBarControl
//
//  Created by Cédric Foellmi on 09/05/16.
//  Licensed under the MIT License (see LICENSE file)
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
        let indexPath = IndexPath()
        XCTAssertTrue(indexPath.lastIndex() == NSNotFound)
    }
    
    func testLastIndexNullOneLevelIndexPath() {
        let indexPath = IndexPath(index:0)
        XCTAssertTrue(indexPath.lastIndex() == 0)
    }
    
    func testLastIndexNegativeOneLevelIndexPath() {
        let indexPath = IndexPath(index:-23)
        XCTAssertTrue(indexPath.lastIndex() == -23)
    }
    
    func testLastIndexPositiveOneLevelIndexPath() {
        let indexPath = IndexPath(index:42)
        XCTAssertTrue(indexPath.lastIndex() == 42)
    }
    
    func testLastIndexNullMultipleLevelIndexPath() {
        let indexPath = IndexPath(index:17).indexPathByAddingIndex(34).indexPathByAddingIndex(0)
        XCTAssertTrue(indexPath.lastIndex() == 0)
    }
    
    func testLastIndexNegativeMultipleLevelIndexPath() {
        let indexPath = IndexPath(index:17).indexPathByAddingIndex(34).indexPathByAddingIndex(-24)
        XCTAssertTrue(indexPath.lastIndex() == -24)
    }
    
    func testLastIndexPositiveMultipleLevelIndexPath() {
        let indexPath = IndexPath(index:17).indexPathByAddingIndex(34).indexPathByAddingIndex(43)
        XCTAssertTrue(indexPath.lastIndex() == 43)
    }
    
    
    // MARK: - indexPathByAddingIndexPath
    
    func testAddingNilToEmptyIndexPath() {
        let indexPath = IndexPath()
        let newIndexPath = indexPath.indexPathByAddingIndexPath(nil)
        XCTAssertEqual(indexPath, newIndexPath);
    }
    
    func testAddingNilToValidIndexPath() {
        let indexPath = IndexPath(index:42)
        let newIndexPath = indexPath.indexPathByAddingIndexPath(nil)
        XCTAssertEqual(indexPath, newIndexPath);
    }
    
    func testAddingEmptyIndexPathToEmptyIndexPath() {
        let indexPath = IndexPath()
        let newIndexPath = indexPath.indexPathByAddingIndexPath(IndexPath());
        XCTAssertEqual(indexPath, newIndexPath);
    }
    
    func testAddingEmptyIndexPathToValidIndexPath() {
        let indexPath = IndexPath(indexes: [2, 34, 56], length: 3);
        let newIndexPath = indexPath.indexPathByAddingIndexPath(IndexPath());
        XCTAssertEqual(indexPath, newIndexPath);
    }
    
    func testAddingValidIndexPathToEmptyIndexPath() {
        let indexPath = IndexPath(indexes: [2, 34, 56], length: 3);
        let newIndexPath = IndexPath().indexPathByAddingIndexPath(indexPath);
        XCTAssertEqual(indexPath, newIndexPath);
    }
    
    
    
    // MARK: - indexPathByAddingIndexInFront
    
    func testAddingIndexInFrontOfEmptyIndexPath() {
        let indexPath = IndexPath()
        let newIndexPath = indexPath.indexPathByAddingIndexInFront(27);
        XCTAssertEqual(newIndexPath, IndexPath(index:27));
    }
    
    func testAddingPositiveIndexInFrontOfValidIndexPath() {
        let indexPath = IndexPath(indexes:[34, 56, 78], length:3);
        let finalIndexPath = IndexPath(indexes:[2, 34, 56, 78], length:4);
        XCTAssertEqual(indexPath.indexPathByAddingIndexInFront(2), finalIndexPath);
    }
    
    func testAddingNegativeIndexInFrontOfValidIndexPath() {
        let indexPath = IndexPath(indexes:[34, -56, 78], length:3);
        let finalIndexPath = IndexPath(indexes:[-2, 34, -56, 78], length:4);
        XCTAssertEqual(indexPath.indexPathByAddingIndexInFront(-2), finalIndexPath);        
    }

}
