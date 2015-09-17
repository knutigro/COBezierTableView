//
//  COBezierDemoViewController.swift
//  COBezierTableViewDemo
//
//  Created by Knut Inge Grosland on 2015-03-23.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class COBezierDemoViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rect = view.bounds

        /*
          Example of setting up custom static points for usage with COBezierTableView
          This initalization is optional
          Typically after finding your preferred static points, (using the COBezierEditorView)
          you would insert these points here.
        */
        UIView.BezierPoints.p1 = CGPointMake(0, 0)
        UIView.BezierPoints.p2 = CGPointMake(floor(rect.size.height / 3), floor(rect.size.height / 3))
        UIView.BezierPoints.p3 = CGPointMake(floor(rect.size.height / 3), floor(rect.size.height / 2))
        UIView.BezierPoints.p4 = CGPointMake(40, rect.size.height)
    }
    
    // MARK:  UITableViewDataSource Methods
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! COBezierDemoCell
        cell.tag = indexPath.row;
        
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
            if let indexPath = tableView.indexPathForCell(cell) {
                let alert = UIAlertView()
                alert.title = "COBezierTableView"
                alert.message = "Tapped: " + String(indexPath.row)
                alert.addButtonWithTitle("OK")
                alert.show()
            }
        }
    }
}