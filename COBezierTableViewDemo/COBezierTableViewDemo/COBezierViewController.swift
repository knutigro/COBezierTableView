//
//  COBezierViewController.swift
//  COBezierTableViewDemo
//
//  Created by Knut Inge Grosland on 2015-03-20.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class COBezierViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        bezierEditorView.bezierTableView = bezierTableView;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//          if segue.identifier == "openBezierEditorSegue" {
//            if let destination = segue.destinationViewController as? UIViewController {
//                if let bezierTableViewEditor = destination.view as? COBezierTableViewEditor {
//                    var bezierTableView = self.tableView as? COBezierTableView;
//                    bezierTableViewEditor.bezierTableView = bezierTableView?.copy() as? COBezierTableView;
//                }
//            }
//        }
//    }
    
    // MARK:  UITableViewDataSource Methods
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
//        cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
//        cell.textLabel?.text = String(indexPath.row)
        
        return cell
    }
    
    override  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    // MARK:  UITableViewDelegate Methods
    override  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        let alert = UIAlertView()
        alert.title = "BezierListItemView"
        alert.message = "didSelectCellAtIndex: " + String(indexPath.row)
        alert.addButtonWithTitle("OK")
        alert.show()
    }
}