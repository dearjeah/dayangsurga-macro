//
//  UPPersonalInfoListViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import Foundation

class UPPersonalInfoListViewModel: NSObject {
    
    func getEmptyStateId(Id: Int) -> Empty_State?{
        return EmptyStateRepository.shared.getEmptyStateById(id: Id)
    }
    
    func getAllPersonalInfo() -> [User] {
        guard let data = UserRepository.shared.getAllUser() else {
            return [User]()}
        return data
    }
}
