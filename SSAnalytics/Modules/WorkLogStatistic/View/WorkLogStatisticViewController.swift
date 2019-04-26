//
//  WorkLogStatisticViewController.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class WorkLogStatisticViewController: SttViewController<WorkLogStatisticPresenter>, WorkLogStatisticViewDelegate {
    

    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var approvedView: UIView!
    @IBOutlet weak var logTimeView: UIView!
    @IBOutlet weak var pendingView: UIView!
    @IBOutlet weak var rejectedView: UIView!
    
    @IBOutlet weak var approvedPriceLabel: UILabel!
    @IBOutlet weak var approvedHoursLabel: UILabel!
    @IBOutlet weak var logTimePriceLabel: UILabel!
    @IBOutlet weak var logTimeHoursLabel: UILabel!
    @IBOutlet weak var pendingPriceLabel: UILabel!
    @IBOutlet weak var pendingHoursLabel: UILabel!
    @IBOutlet weak var rejectedPriceLabel: UILabel!
    @IBOutlet weak var rejectedHoursLabel: UILabel!
    @IBOutlet weak var monthYearPicker: MonthYearPickerView!
    
    let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
    let currentYear = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
	}
    
    var set: SttBindingSet<WorkLogStatisticViewController>!
    override func bind() {
        set = SttBindingSet(parent: self)
        
        set.bind(approvedPriceLabel).to(presenter.totalSalary).withConverter(SalaryConverter.self)
        set.bind(logTimePriceLabel).to(presenter.totalSalary).withConverter(SalaryConverter.self)
        set.bind(pendingPriceLabel).to(presenter.totalSalary).withConverter(SalaryConverter.self)
        set.bind(rejectedPriceLabel).to(presenter.rejectedSalary).withConverter(SalaryConverter.self)
        
        set.bind(approvedHoursLabel).to(presenter.approved).withConverter(TimeFromSecondsConverter.self)
        set.bind(logTimeHoursLabel).to(presenter.logTime).withConverter(TimeFromSecondsConverter.self)
        set.bind(pendingHoursLabel).to(presenter.pending).withConverter(TimeFromSecondsConverter.self)
        set.bind(rejectedHoursLabel).to(presenter.rejected).withConverter(TimeFromSecondsConverter.self)
        
        set.apply()        
    }
    
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
        monthYearPicker.year = currentYear
        monthYearPicker.month = currentMonth
        self.presenter.getSummary.execute(parametr: "\(monthYearPicker.year)-\(monthYearPicker.month)")
    }
    
	// MARK: - implementation of WorkLogStatisticViewDelegate
}
