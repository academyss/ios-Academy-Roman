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
    
    let id: Dynamic<String>
    let avatarImage: Dynamic<Image>
    let name: Dynamic<String>
    let job: Dynamic<String>
    let phone: Dynamic<String>
    let skype: Dynamic<String?>
    let email: Dynamic<String>
    let isSelected: Dynamic<Bool>
    
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
        self.email = Dynamic(employee.email)
        self.id = Dynamic(employee.id)
        
        self.isSelected = Dynamic(false)
        
        super.init(notificationError: nil)
        
    }
    
    func onSelect() {
        parent?.deselectAll(employeeId: id.value)
        print(isSelected.value)
        isSelected.value.toggle()
        parent?.updateTableView()
    }
    
    func onProfileShow() {
        parent?.navigate(user: self.user)
    }
    
    func onCall() {
        guard let number = URL(string: "tel://" + phone.value) else { return }
        UIApplication.shared.open(number)
        parent?.updateTableView()
    }
    
    func onEmail() {
        let email = self.email.value
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
