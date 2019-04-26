//
//  WorkLogTimeTableViewSource.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/24/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

final class WorkLogTimeTableViewSource: SttTableViewSourceWithSection<WorkLogTimeTableViewCellPresenter, WorkLogTimeViewSectionPresenter> {
    
	convenience init(tableView: UITableView, collection: SttObservableCollection<(SttObservableCollection<WorkLogTimeTableViewCellPresenter>, WorkLogTimeViewSectionPresenter)>) {
        
        self.init(tableView: tableView,
                  cellIdentifiers: [SttIdentifiers(identifers: WorkLogTimeTableViewCell.reusableIdentifier)],
                  collection: collection)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = WorkLogTimeSectionView()
        view.backgroundColor = UIColor(named: "SectionBackground" )
        view.presenter = collection[section].1
        return view
    }
    
    override func cellIdentifier(for indexPath: IndexPath) -> String {
        return WorkLogTimeTableViewCell.reusableIdentifier
    }
    
}
