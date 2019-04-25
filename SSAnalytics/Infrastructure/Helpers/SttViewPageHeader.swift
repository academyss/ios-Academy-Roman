//
//  SttViewPagerHeader.swift
//  Timeslot
//
//  Created by Peter Standret on 4/17/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit

#warning("move to library")

protocol test {
    func onPageChanged()
}

extension UIViewController: test {
    @objc func onPageChanged() {
        print("pageChage")
    }
}

extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    
    var color: UIColor? { return self[.foregroundColor] as? UIColor }
    var font: UIFont? { return self[.font] as? UIFont }
}

public class SttViewPagerHeader: UIView, UIScrollViewDelegate {
    
    public weak var parent: UIViewController!
    public weak var scrollView: UIScrollView!
    
    private(set) public var selectedSegment = 0 {
        didSet {
            parent.onPageChanged()
        }
    }
    
    @objc
    public dynamic var isEquealWidth: Bool {
        get { return segmentControl.apportionsSegmentWidthsByContent }
        set { segmentControl.apportionsSegmentWidthsByContent = newValue }
    }
    
    @objc
    public dynamic var selectedTitleTextColor: UIColor? {
        get { return segmentControl.titleTextAttributes(for: .normal)?.color }
        set {
            var current = segmentControl.titleTextAttributes(for: .selected) ?? [NSAttributedString.Key: Any]()
            current[.foregroundColor] = newValue
            segmentControl.setTitleTextAttributes(current, for: .selected)
        }
    }
    @objc
    public dynamic var selectedTitleFont: UIFont? {
        get { return segmentControl.titleTextAttributes(for: .normal)?.font }
        set {
            var current = segmentControl.titleTextAttributes(for: .selected) ?? [NSAttributedString.Key: Any]()
            current[.font] = newValue
            segmentControl.setTitleTextAttributes(current, for: .selected)
        }
    }
    
    @objc
    public dynamic var titleTextColor: UIColor? {
        get { return segmentControl.titleTextAttributes(for: .normal)?.color }
        set {
            var current = segmentControl.titleTextAttributes(for: .normal) ?? [NSAttributedString.Key: Any]()
            current[.foregroundColor] = newValue
            segmentControl.setTitleTextAttributes(current, for: .normal)
        }
    }
    @objc
    public dynamic var titleTextFont: UIFont? {
        get { return segmentControl.titleTextAttributes(for: .normal)?.font }
        set {
            var current = segmentControl.titleTextAttributes(for: .normal) ?? [NSAttributedString.Key: Any]()
            current[.font] = newValue
            segmentControl.setTitleTextAttributes(current, for: .normal)
        }
    }
    
    @objc
    public dynamic var underlineColor: UIColor? {
        get { return underline.backgroundColor }
        set { underline.backgroundColor = newValue }
    }
    
    @objc
    public dynamic var underlineCarretCollor: UIColor? {
        get { return underlineCarret.backgroundColor }
        set { underlineCarret.backgroundColor = newValue }
    }
    
    private var segmentControl: UISegmentedControl!
    
    private var underline: UIView!
    private var underlineCarret: UIView!
    
    private var headerScrollView: UIScrollView!
    
    private var views = [(title: String, view: UIViewController)]()
    private var elementsWidth = [CGFloat]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        viewDidLoad()
    }
    
    override public func prepareForInterfaceBuilder() {
        viewDidLoad()
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard views.count > 0 else { fatalError("count of tab could not be 0") }
        guard scrollView != nil else { fatalError("no one scroll view was not linked") }
        guard parent != nil else { fatalError("parent was not set") }
        
        drawElement(rect: rect)
    }
    
    func setItem(view: UIViewController, title: String) {
        views.append((title: title, view: view))
    }
    
    private func viewDidLoad() {
        segmentControl = UISegmentedControl()
        segmentControl.addTarget(self, action: #selector(onValueChanged(_:)), for: .valueChanged)
        
        underline = UIView()
        underlineCarret = UIView()
        
        headerScrollView = UIScrollView()
        headerScrollView.bounces = false
        headerScrollView.showsVerticalScrollIndicator = false
        headerScrollView.showsHorizontalScrollIndicator = false
        headerScrollView.isScrollEnabled = false
        
        addSubview(headerScrollView)
        headerScrollView.addSubview(segmentControl)
        headerScrollView.addSubview(underline)
        headerScrollView.addSubview(underlineCarret)
    }
    
    private var firstStart = true
    private func drawElement(rect: CGRect) {
        
        guard firstStart else { return }
        firstStart = false
        
        selectedSegment = 0
        segmentControl.selectedSegmentIndex = selectedSegment
        segmentControl.frame = CGRect(x: 0, y: 0, width: rect.width, height: 44)
        underline.frame = CGRect(x: 0, y: 44, width: rect.width, height: 1)
        headerScrollView.frame = rect
        
        scrollView.delegate = self
        insertInScrollView()
        
        scrollView.isPagingEnabled = true
        redrawUnderline()
        
        segmentControl.tintColor = .clear
        
        #warning("not implemented max width")
        
        if true {
            headerScrollView.contentSize = rect.size
            underlineCarret.frame = CGRect(x: 0, y: 43, width: rect.width / CGFloat(views.count), height: 2)
        }
    }
    
    private var isInitialized = false
    private func insertInScrollView() {
        
        guard !isInitialized else { return }
        isInitialized = true
        
        scrollView.contentSize = CGSize(width: CGFloat(views.count) * scrollView.frame.width, height: scrollView.frame.height)
        
        for (index, value) in views.enumerated() {
            value.view.view.frame = CGRect(x: CGFloat(index) * scrollView.frame.width,
                                           y: 0,
                                           width: scrollView.frame.width,
                                           height: scrollView.frame.height)
            
            value.view.willMove(toParent: parent)
            parent.addChild(value.view)
            value.view.didMove(toParent: parent)
            
            scrollView.addSubview(value.view.view)
            segmentControl.insertSegment(withTitle: value.title, at: index, animated: true)
        }
        
        segmentControl.selectedSegmentIndex = 0
    }
    
    private func redrawUnderline() {
        let normPosition = headerScrollView.contentSize.width * scrollView.contentOffset.x / scrollView.contentSize.width
        
        underlineCarret.frame = CGRect(x: normPosition,
                                       y: underlineCarret.frame.origin.y,
                                       width: underlineCarret.frame.width,
                                       height: underlineCarret.frame.height)
        
        if headerScrollView.contentSize.width > headerScrollView.frame.width {
            headerScrollView.contentOffset = CGPoint(x: normPosition / CGFloat(views.count), y: headerScrollView.contentOffset.y)
        }
    }
    
    @objc
    private func onValueChanged(_ sender: UISegmentedControl) {
        let position = scrollView.frame.width * CGFloat(segmentControl.selectedSegmentIndex)
        scrollView.setContentOffset(CGPoint(x: position, y: 0), animated: true)
    }
    
    // MARK: - implementation of UIScrollViewDelegate
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        segmentControl.selectedSegmentIndex = page
        selectedSegment = page
        
        redrawUnderline()
    }
}
