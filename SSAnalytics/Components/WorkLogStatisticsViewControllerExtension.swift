//
//  WorkLogStatisticsViewControllerExtension.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 5/6/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import UIKit


extension WorkLogStatisticViewController {
    
    func initialSetup() {
        
        self.title = "Work Log"
        
        approvedView.backgroundColor = UIColor(named: "WorkLogApproved")
        logTimeView.backgroundColor = UIColor(named: "LogTime")
        pendingView.backgroundColor = UIColor(named: "Pending")
        rejectedView.backgroundColor = UIColor(named: "Rejected")
        
        rejectedPriceLabel.text = "0$"
        rejectedHoursLabel.text = "0h 0m"
        
        
        
        monthYearPicker.year = currentYear
        monthYearPicker.month = currentMonth
        monthYearPicker.onDateSelected = { (month: Int, year: Int) in
            
            let dateString = "\(year)-\(month)"
            self.presenter.getSummary.execute(parametr: dateString)
        }
        
        self.presenter.getSummary.execute(parametr: "\(monthYearPicker.year)-\(monthYearPicker.month)")
        
        setupButton()
    }
    
    func setupButton() {
        todayButton.layer.cornerRadius = 15
        todayButton.layer.borderColor = UIColor.black.cgColor
        todayButton.layer.borderWidth = 1
        todayButton.tintColor = UIColor.black
        todayButton.addTarget(self, action: #selector(onToday), for: .touchDown)
    }
    
    @objc func onToday() {
        self.todayButton.backgroundColor = UIColor(named: "LightGray")
        monthYearPicker.year = currentYear
        monthYearPicker.month = currentMonth
        self.presenter.getSummary.execute(parametr: "\(monthYearPicker.year)-\(monthYearPicker.month)")
        self.todayButton.backgroundColor = UIColor.white
    }
    
}
