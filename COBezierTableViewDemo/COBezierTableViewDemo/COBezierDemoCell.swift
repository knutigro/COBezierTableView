//
//  COBezierCell.swift
//  COBezierTableViewDemo
//
//  Created by Knut Inge Grosland on 2015-03-23.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class COBezierDemoCell: UITableViewCell {

    @IBOutlet weak var button: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button?.backgroundColor = UIColor.randomColor()
        backgroundColor = UIColor.clear
    }

}

// MARK: Random Color

extension UIColor {
    static func randomColor() -> UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
