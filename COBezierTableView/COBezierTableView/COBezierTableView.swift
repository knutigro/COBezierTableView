//
//  COBezierTableView.swift
//  COBezierTableView
//
//  Created by Knut Inge Grosland on 2015-02-24.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit
import Darwin

let COCellIdentifier = "Cell"

// MARK: - COBezierScrollView
public class COBezierScrollView: UIScrollView {
    func bezierPosition(#offset : CGFloat) -> CGPoint {
        let y = offset - self.contentOffset.y
        return self.bezierPointFor(y/700)
    }
}

// MARK: - COBezierTableView
public class COBezierTableView: UITableView {

    // MARK: Init and setup

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setupBezierTableView()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        setupBezierTableView()
    }

    final private func setupBezierTableView() {
        self.backgroundColor = UIColor.blackColor()
    }
    
    // MARK: - Layout
    public override func layoutSubviews() {
        
//        mTotalCellsVisible = self.frame.size.height / self.rowHeight;
//        [self resetContentOffsetIfNeeded];
        
        super.layoutSubviews()
        layoutVisibleCells()
    }

    func layoutVisibleCells() {
        let indexpaths = self.indexPathsForVisibleRows()!;
        let totalVisibleCells = indexpaths.count - 1

        for index in 0...totalVisibleCells {
            let indexPath = indexpaths[index] as NSIndexPath
            let cell = self.cellForRowAtIndexPath(indexPath)!
            var frame = cell.frame
            frame.origin.x = bezierYFor(frame.origin.y)
            cell.frame = frame;
        }
    }
}