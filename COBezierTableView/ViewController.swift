//
//  ViewController.swift
//  COBezierTableView
//
//  Created by Knut Inge Grosland on 2015-03-03.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, COBezierTableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var bezierEditorView = COBezierTableViewEditor(frame: self.view.bounds);
        bezierEditorView.delegate = self
        bezierEditorView.dataSource = MyBezierDataSource()
        bezierEditorView.registerNib(UINib(nibName: "MyBezierTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.view .addSubview(bezierEditorView)
        
//        var bezierTableView = COBezierTableView(frame: self.view.bounds);
//        self.view .addSubview(bezierTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // COBezierTableViewDelegate
    func bezierTableView(bezierTableView: COBezierTableView, didSelectCellAtIndex index: Int) {
        let alert = UIAlertView()
        alert.title = "BezierListItemView"
        alert.message = "Here's a message"
        alert.addButtonWithTitle("OK")
        alert.show()
    }

}

