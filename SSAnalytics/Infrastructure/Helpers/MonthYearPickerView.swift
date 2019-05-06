//
//  MonthYearPickerView.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/25/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import UIKit

class MonthYearPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    var months: [String]!
    var years: [Int]!

    var month = Calendar.current.component(.month, from: Date()) {
        didSet {
            selectRow(month - 1, inComponent: 0, animated: true)
        }
    }

    var year = Calendar.current.component(.year, from: Date()) {
        didSet {
            selectRow(years.index(of: year) ?? years.last!, inComponent: 1, animated: true)
        }
    }

    var onDateSelected: ((_ month: Int, _ year: Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }

    func commonSetup() {
        var years: [Int] = []
        if years.count == 0 {
            var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date) - 3
            for _ in 1...4 {
                years.append(year)
                year += 1
            }
        }
        self.years = years

        var months: [String] = []
        var month = 0
        for _ in 1...12 {
            months.append(DateFormatter().monthSymbols[month].capitalized)
            month += 1
        }
        self.months = months

        self.delegate = self
        self.dataSource = self


    }

    // Mark: UIPicker Delegate / Data Source

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return months[row]
        case 1:
            return "\(years[row])"
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return months.count
        case 1:
            return years.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var month = self.selectedRow(inComponent: 0)+1
        var year = years[self.selectedRow(inComponent: 1)]
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM"
        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
        let currentYear = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
        if let pickedDate = dateFormater.date(from: "\(year)-\(month)"){
            if pickedDate > Date() {
                year = currentYear
                month = currentMonth
            }
        }
        if let block = onDateSelected {
            block(month, year)
        }

        self.month = month
        self.year = year
    }

}
