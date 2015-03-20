//
//  COBezierTableView.swift
//  COBezierTableView
//
//  Created by Knut Inge Grosland on 2015-02-24.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit
import Darwin

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
    }
    
    // MARK: - Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutVisibleCells()
    }

    func layoutVisibleCells() {
        
        let indexpaths = self.indexPathsForVisibleRows()!;
        let totalVisibleCells = indexpaths.count - 1
        if totalVisibleCells <= 0 { return }
        
        for index in 0...totalVisibleCells {
            let indexPath = indexpaths[index] as NSIndexPath
            let cell = self.cellForRowAtIndexPath(indexPath)!
            var frame = cell.frame
            
            if let superView = self.superview {
                let point = convertPoint(frame.origin, toView:superView)
                let pointScale = point.y / CGFloat(superView.bounds.size.height)
                frame.origin.x = bezierXFor(pointScale)
            }
            cell.frame = frame;
        }
    }
}