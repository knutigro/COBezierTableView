//
//  COBezierTableView.swift
//  COBezierTableView
//
//  Created by Knut Inge Grosland on 2015-02-24.
//  Copyright (c) 2015 Knut Inge Grosland
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//


import UIKit

open class COBezierTableView: UITableView {

    // MARK: - Layout

    open override func layoutSubviews() {
        super.layoutSubviews()
        updateBezierPointsIfNeeded(bounds)
        layoutVisibleCells()
    }

    func layoutVisibleCells() {
        
        guard let indexpaths = indexPathsForVisibleRows else { return }
        
        let totalVisibleCells = indexpaths.count - 1
        if totalVisibleCells <= 0 { return }
        
        for index in 0...totalVisibleCells {
            let indexPath = indexpaths[index] 
            if let cell = cellForRow(at: indexPath) {
                var frame = cell.frame
                
                if let superView = superview {
                    let point = convert(frame.origin, to:superView)
                    let pointScale = point.y / CGFloat(superView.bounds.size.height)
                    frame.origin.x = bezierXFor(pointScale)
                }
                cell.frame = frame
            }
        }
    }
}
