//
//  WorkLogViewController.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class WorkLogViewController: SttViewController<WorkLogPresenter>, WorkLogViewDelegate {
    
    @IBOutlet weak var viewPager: SttViewPagerHeader!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var filterBarButton: UIBarButtonItem!

    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        viewPager.parent = self
        viewPager.scrollView = scrollView

        let vcStats = storyboard!.instantiateViewController(withIdentifier: "WorkLogStatistic")
        let vcLogTime = storyboard!.instantiateViewController(withIdentifier: "WorkLogLogTime")
        
        navigationController?.navigationBar.tintColor = .black
        viewPager.setItem(view: vcStats, title: "Summary")
        viewPager.setItem(view: vcLogTime, title: "Log Time")
        viewPager.titleTextColor = .black
        viewPager.underlineCarretCollor = .blue
        
        self.title = "Work log"
        initialSetup()
	}
    
    
    func initialSetup() {
        self.filterBarButton = UIBarButtonItem(image: UIImage(named: "Filter"), style: .plain, target: self, action: #selector(showFilterPage))
    }
    
    
    
    override func onPageChanged() {
        if viewPager.selectedSegment == 1 {
            navigationItem.rightBarButtonItem = filterBarButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    
    @objc func showFilterPage() {
        
    }

	// MARK: - implementation of WorkLogViewDelegate
}
