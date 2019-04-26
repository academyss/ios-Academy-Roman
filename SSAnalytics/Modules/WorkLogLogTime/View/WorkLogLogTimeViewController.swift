//
//  WorkLogLogTimeViewController.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class WorkLogLogTimeViewController: SttViewController<WorkLogLogTimePresenter>, WorkLogLogTimeViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var source: WorkLogTimeTableViewSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    var set: SttBindingSet<WorkLogLogTimeViewController>!
    override func bind() {
        set = SttBindingSet(parent: self)
        source = WorkLogTimeTableViewSource(tableView: tableView, collection: presenter.itemsCollection)
        set.apply()
    }
    
    func updateTableView() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // MARK: - implementation of WorkLogLogTimeViewDelegate
}
