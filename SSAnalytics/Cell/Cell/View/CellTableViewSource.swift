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
        collection.append(CellTableViewCellPresenter(avatarImage: "data:image/png;base64,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", name: "jfadfkjdasf", job: "fdksafja"))
        collection.append(CellTableViewCellPresenter(avatarImage: "fadsjkfdjas", name: "jfadfkjdasf", job: "fdksafja"))
        collection.append(CellTableViewCellPresenter(avatarImage: "fadsjkfdjas", name: "jfadfkjdasf", job: "fdksafja"))
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
