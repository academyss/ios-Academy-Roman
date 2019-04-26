//
//  WorkLogLogTimeInteractorType.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift
import STT

protocol WorkLogLogTimeInteractorType {
    func getWorkLogDiary(data: WorkLogDiaryRequestApiModel) -> Observable<[(SttObservableCollection<WorkLogTimeTableViewCellPresenter>, WorkLogTimeViewSectionPresenter)]>
}
