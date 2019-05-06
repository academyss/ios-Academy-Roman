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
    var paramTest: WorkLogLogTimeViewDelegate!
    
    override func viewDidLoad() {
        self.useErrorLabel = false
        super.viewDidLoad()
        initialSetup()
    }
    
    override func onPageChanged() {
        if viewPager.selectedSegment == 1 {
            navigationItem.rightBarButtonItem = filterBarButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    
    @objc func showFilterPage() {
        presenter.showFilter.execute()
    }
    
    func goToLogTime(param: WorkLogDiaryRequestApiModel) {
        viewPager.goToPage(page: 1)
        paramTest.passParameterToPage(param: param)
    }
    
    // MARK: - implementation of WorkLogViewDelegate
}
