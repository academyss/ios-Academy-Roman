//
//  Converter.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation

import STT

class TimeFromSecondsConverter: SttConverter<Int, String> {
    
    override func convert(value: Int, parametr: Any?) -> String {
        let hours = value / 3600
        let minutes = (value - hours * 3600) / 60
        
        return "\(hours)h \(minutes)m"
    }    
}

class SalaryConverter: SttConverter<Double, String> {
    override func convert(value: Double, parametr: Any?) -> String {
        return "\(value)$"
    }
}

class DateConverter: SttConverter<String, String> {
    
    override func convert(value: String, parametr: Any?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: value) {
            dateFormatter.dateFormat = "EEEE, dd"
            var result = dateFormatter.string(from: date)
            result += " of "
            dateFormatter.dateFormat = "MMMM yyyy"
            result += dateFormatter.string(from: date)
            return result
        }
        return value
        
    }
    
}

class StartTimeConverter: SttConverter<String,String> {
    override func convert(value: String, parametr: Any?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: value) {
            return getTimeFromDate(date: date)
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from: value) {
                return getTimeFromDate(date: date)
            }
        }
        return value
    }
    
    func getTimeFromDate(date: Date) ->  String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        let time = dateFormatter.string(from: date)
        return time
    }
}

class DateForDatePickerConverter: SttConverter<Date, String?> {
    override func convert(value: Date, parametr: Any?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let result = dateFormatter.string(from: value)
        return result
    }
}

class WorkLogStatusConverter: SttConverter<WorkLogStatuses, String> {
    override func convert(value: WorkLogStatuses, parametr: Any?) -> String {
        switch value {
        case .approved:
            return "Approved"
        case .pending:
            return "Pending"
        case .rejected:
            return "Rejected"
        }
    }
}

