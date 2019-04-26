//
//  WorkLogLogTimePresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT
import RxSwift

final class WorkLogLogTimePresenter: SttPresenter<WorkLogLogTimeViewDelegate>, WorkLogTimeTableViewCellDelegate {
    
    
    
    private let _router: WorkLogLogTimeRouterType
    private let _interactor: WorkLogLogTimeInteractorType
    
    private(set) lazy var download: SttCommand = SttCommand(delegate: self, handler: { $0.onDownload() })
    
    var itemsCollection = SttObservableCollection<(SttObservableCollection<WorkLogTimeTableViewCellPresenter>, WorkLogTimeViewSectionPresenter)>()
    let disposeBag = DisposeBag()
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: WorkLogLogTimeRouterType,
         interactor: WorkLogLogTimeInteractorType) {
        
        _router = router
		_interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
        
    }
    
    override func viewAppearing() {
        download.execute()
    }
    
//    override func viewAppeared() {
//        itemsCollection.append((SttObservableCollection([WorkLogTimeTableViewCellPresenter(projectName: "jfjadsjfkdsk", spendedTime: "fjjdajfj", describtion: "fjajdfka", startTime: "fgjadjgfja", status: "gadjskjk"),WorkLogTimeTableViewCellPresenter(projectName: "jfjadsjfkdsk", spendedTime: "fjjdajfj", describtion: "fjajdfka", startTime: "fgjadjgfja", status: "gadjskjk"),WorkLogTimeTableViewCellPresenter(projectName: "jfjadsjfkdsk", spendedTime: "fjjdajfj", describtion: "fjajdfka", startTime: "fgjadjgfja", status: "gadjskjk"),WorkLogTimeTableViewCellPresenter(projectName: "jfjadsjfkdsk", spendedTime: "fjjdajfj", describtion: "fjajdfka", startTime: "fgjadjgfja", status: "gadjskjk")]), WorkLogTimeViewSectionPresenter(day: "fjdafjdkfja", spendedTime: "fjadkfjakdjfk")))
//        itemsCollection.append((SttObservableCollection([WorkLogTimeTableViewCellPresenter(projectName: "jfjadsjfkdsk", spendedTime: "fjjdajfj", describtion: "fjajdfka", startTime: "fgjadjgfja", status: "gadjskjk")]), WorkLogTimeViewSectionPresenter(day: "fjdafjdkfja", spendedTime: "fjadkfjakdjfk")))
//        itemsCollection.append((SttObservableCollection([WorkLogTimeTableViewCellPresenter(projectName: "jfjadsjfkdsk", spendedTime: "fjjdajfj", describtion: "fjajdfka", startTime: "fgjadjgfja", status: "gadjskjk")]), WorkLogTimeViewSectionPresenter(day: "fjdafjdkfja", spendedTime: "fjadkfjakdjfk")))
//        itemsCollection.append((SttObservableCollection([WorkLogTimeTableViewCellPresenter(projectName: "jfjadsjfkdsk", spendedTime: "fjjdajfj", describtion: "fjajdfka", startTime: "fgjadjgfja", status: "gadjskjk")]), WorkLogTimeViewSectionPresenter(day: "fjdafjdkfja", spendedTime: "fjadkfjakdjfk")))
//        itemsCollection.append((SttObservableCollection([WorkLogTimeTableViewCellPresenter(projectName: "jfjadsjfkdsk", spendedTime: "fjjdajfj", describtion: "fjajdfka", startTime: "fgjadjgfja", status: "gadjskjk")]), WorkLogTimeViewSectionPresenter(day: "fjdafjdkfja", spendedTime: "fjadkfjakdjfk")))
//        itemsCollection.append((SttObservableCollection([WorkLogTimeTableViewCellPresenter(projectName: "jfjadsjfkdsk", spendedTime: "fjjdajfj", describtion: "fjajdfka", startTime: "fgjadjgfja", status: "gadjskjk")]), WorkLogTimeViewSectionPresenter(day: "fjdafjdkfja", spendedTime: "fjadkfjakdjfk")))
//        itemsCollection.append((SttObservableCollection([WorkLogTimeTableViewCellPresenter(projectName: "jfjadsjfkdsk", spendedTime: "fjjdajfj", describtion: "fjajdfka", startTime: "fgjadjgfja", status: "gadjskjk")]), WorkLogTimeViewSectionPresenter(day: "fjdafjdkfja", spendedTime: "fjadkfjakdjfk")))
//        itemsCollection.forEach { (item) in
//            item.0.forEach({ $0.parent = self })
//        }
//
//    }

    func onDownload() {
        _interactor.getWorkLogDiary(data: WorkLogDiaryRequestApiModel(startDate: "2019-02-18", endDate: "2019-04-30", projectsId: [], workLogStatuses: []))
            .subscribe(onNext: { items in
                self.itemsCollection.append(contentsOf: items)
                self.itemsCollection.forEach({ $0.0.forEach({ $0.parent = self})})
            }).disposed(by: disposeBag)
    }
    
    func updateTableView() {
        delegate?.updateTableView()
    }
}
