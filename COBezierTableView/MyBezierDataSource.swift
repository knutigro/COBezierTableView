//
//  COBezierListViewDataSource.swift
//  COBezierScrollView
//
//  Created by Knut Inge Grosland on 2015-02-24.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class MyBezierDataSource : NSObject, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(COCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        cell.backgroundColor = UIColor.redColor()
        cell.textLabel?.text = String(indexPath.row)
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
}
