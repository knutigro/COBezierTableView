//
//  COBezierListViewDataSource.swift
//  COBezierScrollView
//
//  Created by Knut Inge Grosland on 2015-02-24.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

public class MyBezierDataSource : COBezierTableViewDataSource {
    
    public func bezierTableView(bezierTableView: COBezierTableView, sizeForCellAtIndex index: Int) -> CGSize {
        return CGSizeMake(100, 50)
    }
    
    public func bezierTableViewCellPadding(bezierTableView: COBezierTableView) -> CGFloat {
        return 50.0
    }
    
    public func bezierTableView(bezierTableView: COBezierTableView, cellForRowAtIndex index: Int) -> COBezierTableViewCell {
        var cell = bezierTableView.dequeueReusableCellWithIdentifer("cell", forIndex: index) as? MyBezierTableViewCell
        cell?.backgroundColor = UIColor.redColor()
        cell?.textLabel?.text = String(index)
        
        return cell!

    }
    
    public func bezierTableViewNumberOfCells(bezierTableView: COBezierTableView) -> NSInteger {
        return 30
    }
}
