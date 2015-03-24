//
//  COBezierDemoViewController.swift
//  COBezierTableViewDemo
//
//  Created by Knut Inge Grosland on 2015-03-23.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class COBezierDemoViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK:  UITableViewDataSource Methods
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as COBezierDemoCell
        
        return cell
    }
    
    override  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    // MARK:  Actions
    
    @IBAction func buttonTapped(sender: UIButton) {
        if let cell = sender.superview?.superview as? COBezierDemoCell {
            if let indexPath = self.tableView.indexPathForCell(cell) {
                let row = indexPath.row
                let alert = UIAlertView()
                alert.title = "COBezierTableView"
                alert.message = "Tapped: " + String(indexPath.row)
                alert.addButtonWithTitle("OK")
                alert.show()
            }
        }
    }
}