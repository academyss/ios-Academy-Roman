//
//  ProjectCollectionViewSource.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

final class ProjectCollectionViewSource: SttCollectionViewSource<ProjectCollectionViewCellPresenter>, UICollectionViewDelegateFlowLayout {
    
	convenience init(collectionView: UICollectionView, collection: SttObservableCollection<ProjectCollectionViewCellPresenter>) {
        
        self.init(collectionView: collectionView,
                  cellIdentifiers: [SttIdentifiers(identifers: ProjectCollectionViewCell.reusableIdentifier)],
                  collection: collection)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collection[indexPath.row].name.value) as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18)!]).width + 13 + 30, height: 35)
    }

}
