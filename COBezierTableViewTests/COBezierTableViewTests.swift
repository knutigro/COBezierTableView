//
//  COBezierTableViewTests.swift
//  COBezierTableViewTests
//
//  Created by Knut Inge Grosland on 2015-03-03.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit
import XCTest
import COBezierTableView

class COBezierDataSourceTest : COBezierTableViewDataSource {
    
    func bezierTableView(bezierTableView: COBezierTableView, sizeForCellAtIndex index: Int) -> CGSize {
        return CGSizeMake(100, 50)
    }
    
    func bezierTableViewCellPadding(bezierTableView: COBezierTableView) -> CGFloat {
        return 50.0
    }
    
    func bezierTableView(bezierTableView: COBezierTableView, cellForRowAtIndex index: Int) -> COBezierTableViewCell {
        var cell = bezierTableView.dequeueReusableCellWithIdentifer("cell", forIndex: index) as? MyBezierTableViewCell
        cell?.backgroundColor = UIColor.redColor()
        
        return cell!
        
    }
    
    func bezierTableViewNumberOfCells(bezierTableView: COBezierTableView) -> NSInteger {
        return 30
    }
}

class COBezierTableViewTests: XCTestCase {
    
    let bezierTableView = COBezierTableView(frame: CGRectMake(0, 0, 322, 22))
    let dataSource = COBezierDataSourceTest()
    
    override func setUp() {
        super.setUp()
        bezierTableView.dataSource = dataSource
        bezierTableView.registerNib(UINib(nibName: "MyBezierTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        bezierTableView.layoutSubviews()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDidAddCellsToTableView() {
        let totalCells = dataSource.bezierTableViewNumberOfCells(bezierTableView)
        if (totalCells > 0) {
            XCTAssertGreaterThan(bezierTableView.bezierContentView.subviews.count, 0, "TableView should at least add one view if datasource has data")
        } else {
            XCTAssertEqual(bezierTableView.bezierContentView.subviews.count, 0, "If there is 0 items in datasource. Also ")
        }
        
        XCTAssertNotEqual(bezierTableView.bezierContentView.subviews.count, dataSource.bezierTableViewNumberOfCells(bezierTableView), "TableView should recycle views and not add all at once")
    }

    func testPerformanceLayoutSubviewsSmallDataSource() {
        class COBezierDataSourceTestMock : COBezierDataSourceTest {
            override func bezierTableViewNumberOfCells(bezierTableView: COBezierTableView) -> NSInteger {
                return 5
            }
        }
        
        bezierTableView.dataSource = COBezierDataSourceTestMock()
        bezierTableView.layoutSubviews()

        // This is an example of a performance test case.
        self.measureBlock() {
            self.bezierTableView.reloadData()
            self.bezierTableView.layoutSubviews()
        }
    }
    
    func testPerformanceLayoutSubviewsMediumDataSource() {
        class COBezierDataSourceTestMock : COBezierDataSourceTest {
            override func bezierTableViewNumberOfCells(bezierTableView: COBezierTableView) -> NSInteger {
                return 100
            }
        }
        
        bezierTableView.dataSource = COBezierDataSourceTestMock()
        bezierTableView.layoutSubviews()
        
        // This is an example of a performance test case.
        self.measureBlock() {
            self.bezierTableView.reloadData()
            self.bezierTableView.layoutSubviews()
        }
    }
    
    func testPerformanceLayoutSubviewsBigDataSource() {
        class COBezierDataSourceTestMock : COBezierDataSourceTest {
            override func bezierTableViewNumberOfCells(bezierTableView: COBezierTableView) -> NSInteger {
                return 10000
            }
        }
        
        bezierTableView.dataSource = COBezierDataSourceTestMock()
        bezierTableView.layoutSubviews()
        
        // This is an example of a performance test case.
        self.measureBlock() {
            self.bezierTableView.reloadData()
            self.bezierTableView.layoutSubviews()
        }
    }
}
