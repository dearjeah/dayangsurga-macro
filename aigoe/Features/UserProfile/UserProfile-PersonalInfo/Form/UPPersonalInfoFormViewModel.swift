//
//  UPPersonalInfoFormViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import Foundation

class UPPersonalInfoFormViewModel: NSObject {
    
    func getPhbyID() -> PersonalInformation_Placeholder?{
        return PersonalInformationPlaceholderRepository.shared.getPIPhById(pi_ph_id: 1)
    }
    
    func createPersonalInformation(userId: Int, username: String, phoneNumber: String, email: String, loc: String, sum: String) {
        UserRepository.shared.createUser(user_id: userId,
                                         username: username,
                                         phoneNumber: phoneNumber,
                                         email: email,
                                         location: loc,
                                         summary: sum)
    }
    
    func update(id: Int, newName: String, newPN: String, newEmail: String, newLoc: String, newSum: String) {
        UserRepository.shared.updateUser(id: id, newName: newName, newPhoneNumber: newPN, newEmail: newEmail, newLocation: newLoc, newSummary: newSum)
    }
    
    func updatePersonalInformation(userId: Int, username: String, phoneNumber: String, email: String, loc: String, sum: String) {
        UserRepository.shared.updateUser(id: userId,
                                         newName: username,
                                         newPhoneNumber: phoneNumber,
                                         newEmail: email,
                                         newLocation: loc,
                                         newSummary: sum)
    }
    
    func deletePersonalInformation(data: User?){
        UserRepository.shared.deleteUser(data: data ?? User())
    }

}
