//
//  COBezierTableViewEditor.swift
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
import Darwin

class COBezierEditorView: UIView {
    
    var pointSelector : UISegmentedControl!
    var startLocation : CGPoint?
    
    // MARK: Init and setup

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupEditorView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEditorView()
    }

    private final func setupEditorView() {
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: Selector("handlePan:")))

        self.pointSelector = UISegmentedControl(frame: CGRectMake(10, CGRectGetMaxY(self.bounds) - 40, CGRectGetWidth(self.bounds) - 20, 30))
        self.pointSelector.autoresizingMask = .FlexibleWidth | .FlexibleTopMargin
        self.pointSelector.insertSegmentWithTitle(NSStringFromCGPoint(bezierStaticPoint(0)), atIndex: 0, animated: false)
        self.pointSelector.insertSegmentWithTitle(NSStringFromCGPoint(bezierStaticPoint(1)), atIndex: 1, animated: false)
        self.pointSelector.insertSegmentWithTitle(NSStringFromCGPoint(bezierStaticPoint(2)), atIndex: 2, animated: false)
        self.pointSelector.insertSegmentWithTitle(NSStringFromCGPoint(bezierStaticPoint(3)), atIndex: 3, animated: false)
        self.pointSelector.selectedSegmentIndex = 0
        self.addSubview(self.pointSelector)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBezierPointsIfNeeded(self.bounds)
    }
    
    // MARK: Drawing

    override func drawRect(rect: CGRect) {
        
        // Draw background
        if let backgroundColor = self.backgroundColor {
            backgroundColor.set()
        } else {
            UIColor.blackColor().set()
        }
        UIBezierPath(rect: rect).fill()
        
        // Draw line
        UIColor.brownColor().setStroke()
        var path = UIBezierPath()
        
        path.moveToPoint(bezierStaticPoint(0))
        path.addCurveToPoint(bezierStaticPoint(3), controlPoint1: bezierStaticPoint(1), controlPoint2: bezierStaticPoint(2))
        path.stroke()
        
        // Draw circles
        UIColor.redColor().setStroke()
        for (var t : CGFloat = 0.0; t <= 1.00001; t += 0.05) {
            let point = bezierPointFor(t)
            let radius : CGFloat = 5.0
            let endAngle : CGFloat = 2.0 * CGFloat(M_PI)
            
            let pointPath = UIBezierPath(arcCenter: point, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
            pointPath.stroke()
        }
    }
    
    // MARK: UIPanGestureRecognizer
    
    func handlePan(recognizer:UIPanGestureRecognizer) {
        
        if recognizer.state == .Began {
            self.startLocation = bezierStaticPoint(self.pointSelector.selectedSegmentIndex)
        } else if recognizer.state == .Changed {
            let translation = recognizer.translationInView(self)
            if let startLocationUnWrapped = self.startLocation {
                var pointToMove = startLocationUnWrapped
                pointToMove.x += floor(translation.x)
                pointToMove.y += floor(translation.y)
                
                if self.pointSelector.selectedSegmentIndex == 0 || self.pointSelector.selectedSegmentIndex == 3 {
                    if (pointToMove.x > self.bounds.width) {
                        pointToMove.x = self.bounds.width
                    }
                    if (pointToMove.x < 0) {
                        pointToMove.x = 0
                    }
                    if self.pointSelector.selectedSegmentIndex == 0 {
                        pointToMove.y = 0
                    } else {
                        pointToMove.y = self.bounds.size.height
                    }
                }
                
                setBezierStaticPoint(pointToMove, forIndex: self.pointSelector.selectedSegmentIndex)
                self.pointSelector.setTitle(NSStringFromCGPoint(bezierStaticPoint(self.pointSelector.selectedSegmentIndex)), forSegmentAtIndex: self.pointSelector.selectedSegmentIndex)
                self.setNeedsDisplay()
            }
        } else if recognizer.state == .Ended {
            recognizer.setTranslation(CGPointZero, inView: self)
        }
    }
}
