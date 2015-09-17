//
//  UView+Bezier.swift
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

import Foundation

import UIKit

public extension UIView {
    
    public struct BezierPoints {
        static var p1 = CGPointZero
        static var p2 = CGPointZero
        static var p3 = CGPointZero
        static var p4 = CGPointZero
    }
    
    func updateBezierPointsIfNeeded(frame : CGRect) {
        if BezierPoints.p1 == CGPointZero
           && BezierPoints.p2 == CGPointZero
           && BezierPoints.p3 == CGPointZero
           && BezierPoints.p4 == CGPointZero {
            BezierPoints.p1 = CGPointMake(0, 0)
            BezierPoints.p2 = CGPointMake(floor( frame.size.height / 3), floor(frame.size.height / 3))
            BezierPoints.p3 = CGPointMake(floor(frame.size.height / 3), floor(frame.size.height / 2))
            BezierPoints.p4 = CGPointMake(40, frame.size.height)
        }
    }
    
    func bezierStaticPoint(index: Int) -> CGPoint {
        switch index {
        case 0 : return BezierPoints.p1
        case 1 : return BezierPoints.p2
        case 2 : return BezierPoints.p3
        case 3 : return BezierPoints.p4
        default : return CGPointZero
        }
    }

    func setBezierStaticPoint(point: CGPoint, forIndex index: Int) {
        switch index {
        case 0 : BezierPoints.p1 = point
        case 1 : BezierPoints.p2 = point
        case 2 : BezierPoints.p3 = point
        case 3 : BezierPoints.p4 = point
        default: CGPointZero
        }
    }
    
    // simple linear interpolation between two points
    func bezierInterpolation(t: CGFloat, a: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat {
        let t2 : CGFloat = t * t
        let t3 : CGFloat = t2 * t
        return a + (-a * 3 + t * (3 * a - a * t)) * t
            + (3 * b + t * (-6 * b + b * 3 * t)) * t
            + (c * 3 - c * 3 * t) * t2
            + d * t3
    }
    
    func bezierXFor(t : CGFloat) -> CGFloat {
        return bezierInterpolation(t, a: BezierPoints.p1.x, b: BezierPoints.p2.x, c: BezierPoints.p3.x, d: BezierPoints.p4.x)
    }

    func bezierYFor(t : CGFloat) -> CGFloat {
        return bezierInterpolation(t, a: BezierPoints.p1.y, b: BezierPoints.p2.y, c: BezierPoints.p3.y, d: BezierPoints.p4.y)
    }
    
    func bezierPointFor(t : CGFloat) -> CGPoint {
        return CGPointMake(bezierXFor(t), bezierYFor(t))
    }
    
    func distanceTop(point : CGPoint) -> CGFloat {
        if let superView = self.superview {
            let relativePoint = convertPoint(point, toView:superView)
            return relativePoint.y / CGFloat(superView.bounds.size.height)
        } else {
            return 0
        }
    }

    func distanceBottom(point : CGPoint) -> CGFloat {
        if let superView = self.superview {
            let relativePoint = convertPoint(point, toView:superView)
            return 1 - (relativePoint.y / CGFloat(bounds.size.height))
        } else {
            return 0
        }
    }
}
