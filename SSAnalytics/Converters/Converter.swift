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
        return ""
        
    }
    
}

class StartTimeConverter: SttConverter<String,String> {
    override func convert(value: String, parametr: Any?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZZZ"
        if let date = dateFormatter.date(from: value) {
            dateFormatter.dateFormat = "hh:mm:ss"
            var time = dateFormatter.string(from: date)
            print(time)
            return time
        } 
        return ""
    }
}

