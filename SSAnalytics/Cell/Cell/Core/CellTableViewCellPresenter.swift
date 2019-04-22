//
//  CellTableViewCellPresenter.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

final class CellTableViewCellPresenter: SttPresenter<CellTableViewCellViewDelegate> {
    
    weak var parent: CellTableViewCellDelegate?
    var user: EmployeeApiModel
    
    var avatarImage: Dynamic<Image>
    var name: Dynamic<String>
    var job: Dynamic<String>
    var phone: Dynamic<String>
    var skype: Dynamic<String?>
    
    var isSelected: Dynamic<Bool>
    
    private(set) lazy var showProfile = SttCommand(delegate: self, handler: { $0.onProfileShow() })
    private(set) lazy var select = SttCommand(delegate: self, handler: { $0.onSelect() })
    private(set) lazy var call = SttCommand(delegate: self, handler: { $0.onCall() })
    private(set) lazy var sendEmail = SttCommand(delegate: self, handler: { $0.onEmail() })
    
    
    init(employee: EmployeeApiModel) {
        self.user = employee
        
        self.avatarImage = Dynamic(Image(data: nil, url: employee.imageUrl))
        self.name = Dynamic(employee.name)
        self.job = Dynamic(employee.roles.joined(separator: ", "))
        self.phone = Dynamic(employee.phoneNumber)
        self.skype = Dynamic(employee.skype)
        
        self.isSelected = Dynamic(true)
        
        super.init(notificationError: nil)
        
    }
    
    func onSelect() {
        print(isSelected.value)
        isSelected.value.toggle()
        parent?.updateTableView()
    }
    
    func onProfileShow() {
        parent?.navigate(user: self.user)
    }
    
    func onCall() {
        print("make call")
    }
    
    func onEmail() {
        print("send email")
    }
}
