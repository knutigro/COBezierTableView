//
//  UView+Bezier.swift
//  COBezierTableView
//
//  Created by Knut Inge Grosland on 2015-02-25.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import Foundation

import UIKit

public extension UIView {
    
    public struct BezierPoints {
        static var p1 = CGPointMake(-3, -8)
        static var p2 = CGPointMake(200, 248)
        static var p3 = CGPointMake(200, 476)
        static var p4 = CGPointMake(37, 562)
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
        let t2 : CGFloat = t * t;
        let t3 : CGFloat = t2 * t;
        return a + (-a * 3 + t * (3 * a - a * t)) * t
            + (3 * b + t * (-6 * b + b * 3 * t)) * t
            + (c * 3 - c * 3 * t) * t2
            + d * t3;
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
}
