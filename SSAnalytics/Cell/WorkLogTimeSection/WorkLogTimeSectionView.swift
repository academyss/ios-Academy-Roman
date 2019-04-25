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
        
        set.bind(dayLabel).to(presenter.day)
        set.bind(spendedTimeLabel).to(presenter.spendedTime)
        
        set.apply()        
    }
    
    private func viewDidLoad() {
        
        initContentView()
        
        backgroundColor = UIColor(named: "LightGray")
    }
    
    private func initContentView() {
        
        contentView = UIView()
        
        addSubview(contentView)
        
        contentView.edgesToSuperview()
        
        initLabels()
    }
    
    private func initLabels() {
        
        dayLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 150, height: 20))
        spendedTimeLabel = UILabel(frame: CGRect(x: -20, y: 20, width: 150, height: 20))
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        spendedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(spendedTimeLabel)
        
        dayLabel.height(18)
        spendedTimeLabel.height(18)
        dayLabel.edgesToSuperview(insets: .left(20) + .top(20) + .bottom(20))
        spendedTimeLabel.edgesToSuperview(insets: .right(20) + .top(20) + .bottom(20))
        dayLabel.edges(to: spendedTimeLabel, excluding: .trailing, insets: .right(10), relation: .equalOrGreater)
    }
    
    
}
