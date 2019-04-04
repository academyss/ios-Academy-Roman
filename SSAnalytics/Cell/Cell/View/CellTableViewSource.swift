//
//  CellTableViewSource.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

final class CellTableViewSource: SttTableViewSource<CellTableViewCellPresenter> {
    
	convenience init(tableView: UITableView, collection: SttObservableCollection<CellTableViewCellPresenter>) {
        
        self.init(tableView: tableView,
                  cellIdentifiers: [SttIdentifiers(identifers: CellTableViewCell.reusableIdentifier)],
                  collection: collection)
    }
}
