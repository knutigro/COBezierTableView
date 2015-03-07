//
//  COBezierTableViewEditor.swift
//  COBezierTableView
//
//  Created by Knut Inge Grosland on 2015-02-23.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit
import Darwin

class COBezierTableViewEditor: COBezierTableView {
    
    enum COBezierTableViewEditorState {
        case None
        case Scroll
        case EditorAndGraph
        case GraphAndScroll
    }
    
    var pointSelector : UISegmentedControl!
    var startLocation : CGPoint?
    var panGesturerecognizer : UIPanGestureRecognizer!

    var state : COBezierTableViewEditorState {
        didSet {
            switch state {
            case .None:
                self.setNeedsDisplay()
            case .Scroll:
                self.removeGestureRecognizer(self.panGesturerecognizer)
                self.bezierScrollView.hidden = false
                self.bezierContentView.hidden = false
                self.pointSelector.hidden = true
                self.reloadData()
                self.setNeedsDisplay()

            case .EditorAndGraph:
                self.addGestureRecognizer(self.panGesturerecognizer)
                self.bezierScrollView.hidden = true
                self.bezierContentView.hidden = true
                self.pointSelector.hidden = false
                self.setNeedsDisplay()

            case .GraphAndScroll:
                self.removeGestureRecognizer(self.panGesturerecognizer)
                self.bezierScrollView.hidden = false
                self.bezierContentView.hidden = false
                self.pointSelector.hidden = true
                self.reloadData()
                self.setNeedsDisplay()
            }
        }
    }
    
    // MARK: Init and setup

    required init(coder aDecoder: NSCoder) {
        self.state = .None
        super.init(coder: aDecoder)
        setupEditorView()
    }
    
    override init(frame: CGRect) {
        self.state = .None
        super.init(frame: frame)
        setupEditorView()
    }
    
    private final func setupEditorView() {
        
        self.panGesturerecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))

        self.pointSelector = UISegmentedControl(frame: CGRectMake(10, CGRectGetMaxY(self.bounds) - 40, CGRectGetWidth(self.bounds) - 20, 30))
        self.pointSelector.autoresizingMask = .FlexibleWidth | .FlexibleTopMargin;
        self.pointSelector.insertSegmentWithTitle(NSStringFromCGPoint(bezierStaticPoint(0)), atIndex: 0, animated: false)
        self.pointSelector.insertSegmentWithTitle(NSStringFromCGPoint(bezierStaticPoint(1)), atIndex: 1, animated: false)
        self.pointSelector.insertSegmentWithTitle(NSStringFromCGPoint(bezierStaticPoint(2)), atIndex: 2, animated: false)
        self.pointSelector.insertSegmentWithTitle(NSStringFromCGPoint(bezierStaticPoint(3)), atIndex: 3, animated: false)
        self.pointSelector.selectedSegmentIndex = 0;
        self.addSubview(self.pointSelector)
        
        var viewSelector = UISegmentedControl(frame: CGRectMake(10, 30, CGRectGetWidth(self.bounds) - 20, 30))
        viewSelector.autoresizingMask = .FlexibleWidth | .FlexibleBottomMargin;
        viewSelector.insertSegmentWithTitle("ScrollView", atIndex: 0, animated: false)
        viewSelector.insertSegmentWithTitle("Scroll + Graph", atIndex: 1, animated: false)
        viewSelector.insertSegmentWithTitle("Editor", atIndex: 2, animated: false)
        viewSelector.addTarget(self, action: Selector("viewSelectorChanged:"), forControlEvents: .ValueChanged)
        viewSelector.selectedSegmentIndex = 1;
        self.addSubview(viewSelector)
        
        self.state = .GraphAndScroll
    }
    
    // MARK: Drawing

    func movePoint(point : CGPoint, byPoint : CGPoint) -> CGPoint {
        var originalPoint = point
        originalPoint.x += byPoint.x
        originalPoint.y += byPoint.y
        
        return originalPoint
    }
    
    override func drawRect(rect: CGRect) {
        
        if (self.state == .EditorAndGraph || self.state == .GraphAndScroll) {
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
    }
    
    // MARK: UIPanGestureRecognizer
    
    func handlePan(recognizer:UIPanGestureRecognizer) {
        
        if recognizer.state == .Began {
            self.startLocation = bezierStaticPoint(self.pointSelector.selectedSegmentIndex)
        } else if recognizer.state == .Changed {
            let translation = recognizer.translationInView(self)
            if let startLocationUnWrapped = self.startLocation {
                setBezierStaticPoint(movePoint(startLocationUnWrapped, byPoint: translation), forIndex: self.pointSelector.selectedSegmentIndex)
                self.pointSelector.setTitle(NSStringFromCGPoint(bezierStaticPoint(self.pointSelector.selectedSegmentIndex)), forSegmentAtIndex: self.pointSelector.selectedSegmentIndex)
                self.setNeedsDisplay()
            }
        } else if recognizer.state == .Ended {
            recognizer.setTranslation(CGPointZero, inView: self)
        }
    }
    
    // MARK: UISegmentedControl

    func viewSelectorChanged(control : UISegmentedControl) {
        switch control.selectedSegmentIndex {
        case 1:
            self.state = .GraphAndScroll
        case 2:
            self.state = .EditorAndGraph
        default:
            self.state = .Scroll
        }
    }
}
