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
        UIView.BezierPoints.p1 = CGPoint(x: 0, y: 0)
        UIView.BezierPoints.p2 = CGPoint(x: floor(rect.size.height / 3), y: floor(rect.size.height / 3))
        UIView.BezierPoints.p3 = CGPoint(x: floor(rect.size.height / 3), y: floor(rect.size.height / 2))
        UIView.BezierPoints.p4 = CGPoint(x: 40, y: rect.size.height)
    }
    
    // MARK:  UITableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! COBezierDemoCell
        
        return cell
    }
    
    override  func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    // MARK:  Actions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? COBezierDemoCell, let indexPath = tableView.indexPath(for: cell) {
            let alert = UIAlertView()
            alert.title = "COBezierTableView"
            alert.message = "Tapped: " + String((indexPath as NSIndexPath).row)
            alert.addButton(withTitle: "OK")
            alert.show()
        }
    }
}
