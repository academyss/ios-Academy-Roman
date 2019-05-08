//
//  WorkLogViewControllerExtension.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 5/3/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import UIKit

extension WorkLogViewController {
    func initialSetup() {
        self.filterBarButton = UIBarButtonItem(image: UIImage(named: "Filter"), style: .plain, target: self, action: #selector(showFilterPage))
        viewPager.parent = self
        viewPager.scrollView = scrollView
        viewPager.backgroundColor = UIColor.clear
        let vcStats = storyboard!.instantiateViewController(withIdentifier: "WorkLogStatistic")
        let vcLogTime = storyboard!.instantiateViewController(withIdentifier: "WorkLogLogTime") as! WorkLogLogTimeViewController
        
        paramTest = vcLogTime
        viewPager.setItem(view: vcStats, title: "Summary")
        viewPager.setItem(view: vcLogTime, title: "Log Time")
        viewPager.titleTextColor = .black
        viewPager.underlineCarretCollor = .blue
        
        self.title = "Work log"
    }
}
