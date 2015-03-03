//
//  COBezierTableView.swift
//  COBezierTableView
//
//  Created by Knut Inge Grosland on 2015-02-24.
//  Copyright (c) 2015 Cocmoc. All rights reserved.
//

import UIKit
import Darwin

protocol COBezierTableViewDelegate:class {
    func bezierTableView(bezierTableView: COBezierTableView, didSelectRowAtIndex index: Int)
}

protocol COBezierTableViewDataSource:class {
    func bezierTableView(bezierTableView: COBezierTableView, heightForRowAtIndex index: Int) -> CGFloat
    func bezierTableViewCellPadding(bezierTableView: COBezierTableView) -> CGFloat
    func bezierTableView(bezierTableView: COBezierTableView, cellForRowAtIndex index: Int) -> COBezierTableViewCell
    func bezierTableViewNumberOfRows(bezierTableView: COBezierTableView) -> NSInteger
}

class COBezierScrollView: UIScrollView {
    func bezierPosition(#offset : CGFloat) -> CGPoint {
        let y = self.frame.size.height - self.contentOffset.y + offset
        return self.bezierPointFor(y/700)
    }
}

class COBezierTableView: UIView, UIScrollViewDelegate, COBezierTableViewDelegate {

    var bezierScrollView : COBezierScrollView!
    
    var visiblePages = [COBezierTableViewCell]()
    var reusablePages = [String : [COBezierTableViewCell]]()
    var registeredClasses = [String : UIView]()
    var registeredNibs = [String : UINib]()
    
    
    weak var delegate:COBezierTableViewDelegate?
    var dataSource:COBezierTableViewDataSource?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBezierTableView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBezierTableView()
    }
    
    private final func setupBezierTableView() {
        self.autoresizingMask = .FlexibleWidth | .FlexibleHeight;
        self.autoresizesSubviews = true;
        self.backgroundColor = UIColor.blackColor()

        self.bezierScrollView = COBezierScrollView(frame: self.bounds)
        self.bezierScrollView.indicatorStyle = .White
        self.bezierScrollView.delegate = self
        self.bezierScrollView.contentSize = CGSizeMake(self.bezierScrollView.frame.width, self.bezierScrollView.frame.height * 2)
        self.bezierScrollView.autoresizingMask = .FlexibleWidth | .FlexibleHeight;
        self.addSubview(self.bezierScrollView)
    }
    
    internal func reloadData() {
        for view in visiblePages {
            view.removeFromSuperview()
        }
        visiblePages.removeAll(keepCapacity: false)
        reusablePages.removeAll(keepCapacity: false)
        self.setNeedsLayout()
    }
    
    private func frameForIndex(idx : Int) -> CGRect {
        
        var frame = CGRectZero
        let height = rowHeight()
        let width = rowHeight() + 50
        let rowPadding = rowPaddding()
        
        let y = self.bezierScrollView.frame.size.height - self.bezierScrollView.contentOffset.y
        let offset = (height + rowPadding) * CGFloat(idx)
        var point = self.bezierScrollView.bezierPosition(offset: offset)

        frame.origin.x = point.x
        frame.origin.y = point.y
        frame.size.width = width
        frame.size.height = height

        return frame
    }

    private func rowHeight() -> CGFloat {
        assert(self.dataSource != nil, "COBezierTableViewDataSource not implemented");
        return self.dataSource!.bezierTableView(self, heightForRowAtIndex: 0)
    }

    private func rowPaddding() -> CGFloat {
        assert(self.dataSource != nil, "COBezierTableViewDataSource not implemented");
        return self.dataSource!.bezierTableViewCellPadding(self)
    }

    private func numberOfRows() -> Int {
        assert(self.dataSource != nil, "COBezierListViewDataSource not implemented");
        return self.dataSource!.bezierTableViewNumberOfRows(self);
    }

    internal func isDisplayingPageAtIndex(idx : Int) -> Bool {
        var isDisplayingPage = false
        for view in visiblePages {
            if (view.tag == idx) {
                isDisplayingPage = true
                break
            }
        }

        return isDisplayingPage
    }
    
    internal func registerClass(pageClass : UIView, forCellReuseIdentifier identifier : String ) {
        registeredClasses[identifier] = pageClass
        registeredNibs.removeValueForKey(identifier)
    }

    internal func registerNib(nib : UINib, forCellReuseIdentifier identifier : String ) {
        registeredNibs[identifier] = nib
        registeredClasses.removeValueForKey(identifier)
    }
    
    internal func dequeueReusablePageWithIdentifer(identifier : String, forIndex index : Int) -> COBezierTableViewCell? {
        var set = reusablePagesWithIdentifier(identifier)
        
        if let reusableView = set.first {
            reusableView.prepareForReuse()
            set.removeAtIndex(0)

            return reusableView
        } else {
            if let pageClass = registeredClasses[identifier] {
                assert(false, "Class initalisation not implemented")
                return nil
            }

            if let registeredNib = registeredNibs[identifier] {
                if let reusableView = registeredNib.instantiateWithOwner(self, options: nil)[0] as? COBezierTableViewCell {
                    return reusableView
                } else {
                    return nil
                }
            }

            return nil
        }
    }

    private func reusablePagesWithIdentifier(identifier : String) -> [COBezierTableViewCell] {
        if let set = reusablePages[identifier] {
            return set
        } else {
            var set = [COBezierTableViewCell]()
            reusablePages[identifier] = set
            return set
        }
    }
    
    private func queuePageForReuse(page : COBezierTableViewCell) {
        if let reuseIdentifier = page.pageReuseIdentifier {
            var set = reusablePagesWithIdentifier(reuseIdentifier)
            set.append(page)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let numberOfRows = self.numberOfRows()
        assert(self.superview != nil, "Need to have a superview to find visibleBounds!")
        let visibleBounds = self.self.clipsToBounds ? self.bounds : self .convertRect(self.superview!.bounds, fromView: self.superview)
        let minY = CGRectGetMinY(visibleBounds)
        let maxY = CGRectGetMaxY(visibleBounds) - 1
        let pageHeight = rowHeight() + rowPaddding()
        
        var firstNeededIndex = Int(floor(minY / pageHeight))
        var lastNeededIndex = Int(floor(maxY / pageHeight))
        
        firstNeededIndex = max(firstNeededIndex, 0)
        lastNeededIndex = min(numberOfRows - 1, lastNeededIndex)
        
        // remove and queue reusable pages
        var removedPages = [Int]()
        
        for visiblePage in visiblePages {
            if visiblePage.tag < firstNeededIndex || visiblePage.tag > lastNeededIndex {
                visiblePage.removeFromSuperview()
                removedPages.append(visiblePage.tag)
                queuePageForReuse(visiblePage)
            }
        }
        for idx in removedPages {
            visiblePages.removeAtIndex(idx)
        }
        
        println("layoutSubviews firstNeededIndex: " + String(firstNeededIndex) + " lastNeededIndex: "  + String(lastNeededIndex))
        
        // layout visible pages
        if numberOfRows > 0 {
            for idx in firstNeededIndex...lastNeededIndex  {
                if !isDisplayingPageAtIndex(idx) {
                    println("will add: " + String(idx))
                    if let page = self.dataSource?.bezierTableView(self, cellForRowAtIndex: idx) {
                        page.frame = frameForIndex(idx)
                        page.tag = idx
                        self.insertSubview(page, atIndex: 0)
                        visiblePages.append(page)
                    }
                }
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for page in visiblePages {
            page.frame = frameForIndex(page.tag)
        }
        setNeedsLayout()
    }
    
    // Mark : COBezierListViewDelegate
    func bezierTableView(bezierTableView: COBezierTableView, didSelectRowAtIndex index: Int) {
    }
    
}