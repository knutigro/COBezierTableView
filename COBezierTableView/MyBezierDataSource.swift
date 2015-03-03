//
//  COBezierListViewDataSource.swift
//  COBezierScrollView
//
//  Created by Knut Inge Grosland on 2015-02-24.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class MyBezierDataSource : COBezierTableViewDataSource {
    
    func bezierTableView(bezierTableView: COBezierTableView, heightForRowAtIndex index: Int) -> CGFloat {
        return 50.0
    }
    
    func bezierTableViewCellPadding(bezierTableView: COBezierTableView) -> CGFloat {
        return 50.0
    }
    
    func bezierTableView(bezierTableView: COBezierTableView, cellForRowAtIndex index: Int) -> COBezierTableViewCell {
        var cell = bezierTableView.dequeueReusablePageWithIdentifer("cell", forIndex: index) as? MyBezierTableViewCell
        cell?.backgroundColor = UIColor.redColor()
        cell?.textLabel?.text = String(index)
        
        return cell!

    }
    
    func bezierTableViewNumberOfRows(bezierTableView: COBezierTableView) -> NSInteger {
        return 30
    }
}
