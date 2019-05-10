//
//  CellTableViewCellDelegate.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation

protocol CellTableViewCellDelegate: AnyObject {
    func navigate(user: EmployeeApiModel)
    func endSearch()
    func updateTableView()
    func deselectAll(employeeId: String)
}
