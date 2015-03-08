//
//  MyBezierTableViewCell.swift
//  COBezierTableView
//
//  Created by Knut Inge Grosland on 2015-03-02.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

public class MyBezierTableViewCell : COBezierTableViewCell {
    
    @IBOutlet weak var textLabel: UILabel?
    
    public override func prepareForReuse() {
        // Should be overriden in superclass
    }
}
