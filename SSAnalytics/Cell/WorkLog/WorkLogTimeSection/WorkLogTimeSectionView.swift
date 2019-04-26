//
//  WorkLogTimeView.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/24/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import UIKit
import TinyConstraints
import STT

class WorkLogTimeSectionView: UIView, SttViewable {
    
    var presenter: WorkLogTimeViewSectionPresenter! {
        didSet {
            self.prepareBind()
        }
    }
    
    private var contentView: UIView!
    private var dayLabel: UILabel!
    private var spendedTimeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        viewDidLoad()
    }
    
    var set: SttBindingSet<WorkLogTimeSectionView>!
    func prepareBind() {
        presenter.injectView(delegate: self)
        
        set = SttBindingSet(parent: self)
        
        set.bind(dayLabel).to(presenter.day).withConverter(DateConverter.self)
        set.bind(spendedTimeLabel).to(presenter.spendedTime).withConverter(TimeFromSecondsConverter.self)
        
        set.apply()        
    }
    
    private func viewDidLoad() {
        
        initContentView()
        
        backgroundColor = UIColor(named: "LightGray")
    }
    
    private func initContentView() {
        
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 30))
        addSubview(contentView)
        
        contentView.edgesToSuperview()
        
        initLabels()
    }
    
    private func initLabels() {
        
        dayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        spendedTimeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        spendedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.textColor = UIColor(named: "Blue")
        spendedTimeLabel.textColor = UIColor(named: "Blue")
        
        contentView.addSubview(dayLabel)
        
        dayLabel.edgesToSuperview(insets: .top(15) + .left(20), relation: ConstraintRelation.equal, priority: LayoutPriority(rawValue: 1000), isActive: true, usingSafeArea: true)
        dayLabel.edgesToSuperview(insets: .right(20), relation: ConstraintRelation.equalOrGreater, priority: LayoutPriority(rawValue: 1000), isActive: true, usingSafeArea: true)
        contentView.addSubview(spendedTimeLabel)
        spendedTimeLabel.edges(to: dayLabel, insets: .left(20), relation: ConstraintRelation.equalOrGreater, priority: LayoutPriority(rawValue: 1000), isActive: true)
        spendedTimeLabel.edgesToSuperview(excluding: LayoutEdge.left, insets: .top(15), relation: .equal, priority: LayoutPriority(rawValue: 1000), isActive: true, usingSafeArea: true)
//        spendedTimeLabel.edgesToSuperview(insets: .top(15) + .right(20) + .bottom(5), relation: ConstraintRelation.equal, priority: LayoutPriority(rawValue: 1000), isActive: true, usingSafeArea: true)

        
    }
    
    
}
