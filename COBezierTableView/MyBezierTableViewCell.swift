//
//  MyBezierTableViewCell.swift
//  COBezierTableView
//
//  Created by Knut Inge Grosland on 2015-03-02.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class MyBezierTableViewCell : COBezierTableViewCell {
    
    @IBOutlet weak var textLabel: UILabel?
    
    override func prepareForReuse() {
        // Should be overriden in superclass
    }
}
