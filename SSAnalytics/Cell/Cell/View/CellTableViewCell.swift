//
//  CellTableViewCell.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class CellTableViewCell: SttTableViewCell<CellTableViewCellPresenter>, CellTableViewCellViewDelegate {

    static let reusableIdentifier = "CellTableViewCell"
    
	override func awakeFromNib() {
        super.awakeFromNib()
        
    }

	override func prepareBind() {
        	super.prepareBind()
        
    }

    // MARK: - implementation of CellTableViewCellViewDelegate
}
