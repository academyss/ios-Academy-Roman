//
//  ProjectTableViewSource.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

final class ProjectTableViewSource: SttTableViewSource<ProjectTableViewCellPresenter> {
    
	convenience init(tableView: UITableView, collection: SttObservableCollection<ProjectTableViewCellPresenter>) {
        
        self.init(tableView: tableView,
                  cellIdentifiers: [SttIdentifiers(identifers: ProjectTableViewCell.reusableIdentifier)],
                  collection: collection)
    }
}
