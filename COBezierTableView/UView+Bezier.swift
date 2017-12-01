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
        public static var p1 = CGPoint.zero
        public static var p2 = CGPoint.zero
        public static var p3 = CGPoint.zero
        public static var p4 = CGPoint.zero
    }
    
    func updateBezierPointsIfNeeded(_ frame : CGRect) {
        if BezierPoints.p1 == CGPoint.zero
           && BezierPoints.p2 == CGPoint.zero
           && BezierPoints.p3 == CGPoint.zero
           && BezierPoints.p4 == CGPoint.zero {
            
            BezierPoints.p1 = CGPoint(x: 0, y: 0)
            BezierPoints.p2 = CGPoint(x: floor( frame.size.height / 3), y:floor(frame.size.height / 3))
            BezierPoints.p3 = CGPoint(x:floor(frame.size.height / 3), y: floor(frame.size.height / 2))
            BezierPoints.p4 = CGPoint(x: 40, y: frame.size.height)
        }
    }
    
    func bezierStaticPoint(_ index: Int) -> CGPoint {
        switch index {
            case 0: return BezierPoints.p1
            case 1: return BezierPoints.p2
            case 2: return BezierPoints.p3
            case 3: return BezierPoints.p4
            default: return CGPoint.zero
        }
    }

    func setBezierStaticPoint(_ point: CGPoint, forIndex index: Int) {
        switch index {
            case 0: BezierPoints.p1 = point
            case 1: BezierPoints.p2 = point
            case 2: BezierPoints.p3 = point
            case 3: BezierPoints.p4 = point
            default: BezierPoints.p4 = CGPoint.zero
        }
    }
    
    // simple linear interpolation between two points
    func bezierInterpolation(_ t: CGFloat, a: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat {
        let t2 : CGFloat = t * t
        let t3 : CGFloat = t2 * t
        return a + (-a * 3 + t * (3 * a - a * t)) * t
            + (3 * b + t * (-6 * b + b * 3 * t)) * t
            + (c * 3 - c * 3 * t) * t2
            + d * t3
    }
    
    func bezierXFor(_ t : CGFloat) -> CGFloat {
        return bezierInterpolation(t, a: BezierPoints.p1.x, b: BezierPoints.p2.x, c: BezierPoints.p3.x, d: BezierPoints.p4.x)
    }

    func bezierYFor(_ t : CGFloat) -> CGFloat {
        return bezierInterpolation(t, a: BezierPoints.p1.y, b: BezierPoints.p2.y, c: BezierPoints.p3.y, d: BezierPoints.p4.y)
    }
    
    func bezierPointFor(_ t : CGFloat) -> CGPoint {
        return CGPoint(x: bezierXFor(t), y: bezierYFor(t))
    }
}
