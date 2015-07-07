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
        button?.backgroundColor = getRandomColor()
        backgroundColor = UIColor.clearColor()
    }

    func getRandomColor() -> UIColor{
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
