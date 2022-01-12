//
//  PersonalInfoFormViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 11/01/22.
//

import Foundation

class PersonalInfoFormViewModel: NSObject {
    let personalInfoRepo = PersonalInfoRepository.shared
    
    func addPersonalInfo(userId: String, name: String, phone: String, email: String, location: String, summary: String) -> Bool {
        return personalInfoRepo.createPersonalInfo(user_id: userId, fullName: name, phoneNumber: phone, email: email, location: location, summary: summary)
    }
    
    func updatePersonalInfo(id: String, name: String, phone: String, email: String, location: String, summary: String) -> Bool {
        return personalInfoRepo.updatePersonalInfo(id: id, newName: name, newPhoneNumber: phone, newEmail: email, newLocation: location, newSummary: summary)
    }
    
    func deletePersonalInfo(data: Personal_Info) -> Bool {
        return personalInfoRepo.deletePersonalInfo(data: data)
    }
}
