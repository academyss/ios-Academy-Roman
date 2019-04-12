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
    
   
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let call = callAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [call])
    }
    
    func callAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let employee = collection[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Call") { (action, view, completion) in
            print(employee)
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "CallIcon")
        action.backgroundColor = UIColor(named: "InputBoxActiveColor")
        
        return action
    }
}
