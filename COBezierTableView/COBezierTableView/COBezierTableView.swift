//
//  COBezierTableView.swift
//  COBezierTableView
//
//  Created by Knut Inge Grosland on 2015-02-24.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit
import Darwin

// MARK: - COBezierScrollView
class COBezierScrollView: UIScrollView {
    func bezierPosition(#offset : CGFloat) -> CGPoint {
        let y = self.frame.size.height - self.contentOffset.y + offset
        return self.bezierPointFor(y/700)
    }
}

// MARK: - COBezierTableViewDelegate
protocol COBezierTableViewDelegate:class {
    func bezierTableView(bezierTableView: COBezierTableView, didSelectCellAtIndex index: Int)
}

// MARK: - COBezierTableViewDataSource
protocol COBezierTableViewDataSource:class {
    func bezierTableView(bezierTableView: COBezierTableView, sizeForCellAtIndex index: Int) -> CGSize
    func bezierTableViewCellPadding(bezierTableView: COBezierTableView) -> CGFloat
    func bezierTableView(bezierTableView: COBezierTableView, cellForRowAtIndex index: Int) -> COBezierTableViewCell
    func bezierTableViewNumberOfCells(bezierTableView: COBezierTableView) -> NSInteger
}

// MARK: - COBezierTableView
class COBezierTableView: UIView, UIScrollViewDelegate, InternalCOBezierTableViewCellDelegate {

    weak var delegate:COBezierTableViewDelegate?
    var dataSource:COBezierTableViewDataSource? {
        didSet {
            let cellHeight = cellSize().height + cellPadding()
            let numberOfCellsFloat = CGFloat(numberOfCells())
            let totalCellHeight = cellHeight * numberOfCellsFloat
            self.bezierScrollView.contentSize =  CGSizeMake(self.bezierScrollView.frame.width, self.bezierScrollView.frame.size.height + totalCellHeight)
        }
    }

    var bezierScrollView : COBezierScrollView!
    var bezierContentView : UIView!
    var visibleCells = [Int : COBezierTableViewCell]()
    var reusableCells = [String : [COBezierTableViewCell]]()
    var registeredClasses = [String : COBezierTableViewCell.Type]()
    var registeredNibs = [String : UINib]()

    // MARK: Init and setup

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBezierTableView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBezierTableView()
    }
    
    final private func setupBezierTableView() {
        self.autoresizingMask = .FlexibleWidth | .FlexibleHeight;
        self.autoresizesSubviews = true;
        self.backgroundColor = UIColor.blackColor()
        
        self.bezierContentView = UIView(frame: self.bounds)
        self.bezierContentView.autoresizingMask = .FlexibleWidth | .FlexibleHeight;
        self.addSubview(self.bezierContentView)

        self.bezierScrollView = COBezierScrollView(frame: self.bounds)
        self.bezierScrollView.indicatorStyle = .White
        self.bezierScrollView.delegate = self
        self.bezierScrollView.contentSize = self.bounds.size
        self.bezierScrollView.autoresizingMask = .FlexibleWidth | .FlexibleHeight;
        self.addSubview(self.bezierScrollView)
    }
    
    // MARK: Public methods

    final func registerClass(cellClass : COBezierTableViewCell.Type, forCellReuseIdentifier identifier : String ) {
        registeredClasses[identifier] = cellClass
        registeredNibs.removeValueForKey(identifier)
    }
    
    final func registerNib(nib : UINib, forCellReuseIdentifier identifier : String ) {
        registeredNibs[identifier] = nib
        registeredClasses.removeValueForKey(identifier)
    }
    
    final func reloadData() {
        for view in visibleCells.values {
            view.removeFromSuperview()
        }
        visibleCells.removeAll(keepCapacity: false)
        reusableCells.removeAll(keepCapacity: false)
        self.setNeedsLayout()
    }
    
    final func dequeueReusableCellWithIdentifer(identifier : String, forIndex index : Int) -> COBezierTableViewCell? {
        var set = reusableCellsWithIdentifier(identifier)
        
        if let reusableCell = set.first {
            reusableCell.prepareForReuse()
            set.removeAtIndex(0)
            
            return reusableCell
        } else {
            if let reusableCell = registeredClasses[identifier] {
                assert(false, "Class initalisation not implemented")
                return nil
            }
            
            if let registeredNib = registeredNibs[identifier] {
                if let reusableCell = registeredNib.instantiateWithOwner(self, options: nil)[0] as? COBezierTableViewCell {
                    return reusableCell
                } else {
                    return nil
                }
            }
            
            return nil
        }
    }

    // MARK: UI

    final private func cellSize() -> CGSize {
        assert(self.dataSource != nil, "COBezierTableViewDataSource not implemented");
        return self.dataSource!.bezierTableView(self, sizeForCellAtIndex: 0)
    }
    
    final private func cellPadding() -> CGFloat {
        assert(self.dataSource != nil, "COBezierTableViewDataSource not implemented");
        return self.dataSource!.bezierTableViewCellPadding(self)
    }
    
    final private func numberOfCells() -> Int {
        assert(self.dataSource != nil, "COBezierListViewDataSource not implemented");
        return self.dataSource!.bezierTableViewNumberOfCells(self);
    }
    
    final private func isDisplayingPageAtIndex(idx : Int) -> Bool {
        return visibleCells[idx] != nil ? true : false
    }
    
    final private func frameForIndex(idx : Int) -> CGRect {
        
        var frame = CGRectZero
        frame.size = cellSize()
        let padding = cellPadding()
        
        let offset = (frame.size.height + padding) * CGFloat(idx)
        var point = self.bezierScrollView.bezierPosition(offset: offset)

        frame.origin.x = point.x
        frame.origin.y = point.y

        return frame
    }
    
    final private func layoutCells() {
        
        let numberOfCells = self.numberOfCells()
        assert(self.bezierContentView.superview != nil, "Need to have a superview to find visibleBounds!")
        let visibleBounds = self.bezierContentView.clipsToBounds ? self.bezierContentView.bounds : self.bezierContentView.convertRect(self.bezierContentView.superview!.bounds, fromView: self.bezierContentView.superview)

        // layout visible pages
        for idx in 0...numberOfCells  {
            if !isDisplayingPageAtIndex(idx) && CGRectIntersectsRect(frameForIndex(idx), visibleBounds) {
                println("will add: " + String(idx))
                if let cell = self.dataSource?.bezierTableView(self, cellForRowAtIndex: idx) {
                    cell.internalCellDelegate = self
                    cell.frame = frameForIndex(idx)
                    cell.tag = idx
                    self.bezierContentView.insertSubview(cell, atIndex: 0)
                    visibleCells[idx] = cell
                }
            }
        }
        
        // remove and queue reusable pages
        var removedCells = [Int]()

        for visibleCell in visibleCells.values {
            visibleCell.frame = frameForIndex(visibleCell.tag)
            if !CGRectIntersectsRect(visibleCell.frame, visibleBounds) {
                println("will remove: " + String(visibleCell.tag))
                visibleCell.removeFromSuperview()
                removedCells.append(visibleCell.tag)
                queueCellsForReuse(visibleCell)
            }
        }

        for idx in removedCells {
            visibleCells[idx] = nil
        }
    }
    
    // MARK: Cells and reuse

    final private func reusableCellsWithIdentifier(identifier : String) -> [COBezierTableViewCell] {
        if let set = reusableCells[identifier] {
            return set
        } else {
            var set = [COBezierTableViewCell]()
            reusableCells[identifier] = set
            return set
        }
    }
    
    final private func queueCellsForReuse(cell : COBezierTableViewCell) {
        if let reuseIdentifier = cell.pageReuseIdentifier {
            var set = reusableCellsWithIdentifier(reuseIdentifier)
            set.append(cell)
        }
    }
    
    // MARK: Layout and scrolling
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutCells()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        setNeedsLayout()
    }

    // MARK:  InternalCOBezierTableViewCellDelegate
    func bezierTableViewCellDidSelect(cell: COBezierTableViewCell) {
        self.delegate!.bezierTableView(self, didSelectCellAtIndex: cell.tag)
    }
}