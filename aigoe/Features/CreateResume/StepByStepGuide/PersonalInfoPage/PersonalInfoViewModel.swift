//
//  PersonalInfoViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation

class PersonalInfoViewModel: NSObject {
    let userRepo = UserRepository.shared
    
    func getUserData() -> User {
        guard let data = userRepo.getUserById(id: 0) else { return User() }
        return data
    }
    
    func getAllUserData() -> [User] {
        return []
    }
}

struct PersonalInformationPlaceholder {
    let fullName, email, phoneNumber, location, summary : String
}

