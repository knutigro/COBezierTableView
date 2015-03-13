//
//  ViewController.swift
//  COBezierTableView
//
//  Created by Knut Inge Grosland on 2015-03-03.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var bezierEditorView = COBezierTableViewEditor(frame: self.view.bounds)
        self.view.addSubview(bezierEditorView)
        
        var bezierTableView = COBezierTableView(frame: self.view.bounds, style: .Plain);
        bezierTableView.backgroundColor = UIColor.clearColor()
        bezierTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: COCellIdentifier)
        bezierTableView.dataSource = self
        bezierEditorView.bezierTableView = bezierTableView;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  UITableViewDataSource Methods

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(COCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        cell.textLabel?.text = String(indexPath.row)
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        let alert = UIAlertView()
        alert.title = "BezierListItemView"
        alert.message = "didSelectCellAtIndex: " + String(indexPath.row)
        alert.addButtonWithTitle("OK")
        alert.show()
    }

}

