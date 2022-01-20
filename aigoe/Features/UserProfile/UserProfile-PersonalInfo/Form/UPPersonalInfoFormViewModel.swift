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
    
    func createPersonalInformation(userId: String, fullName: String, phoneNumber: String, email: String, loc: String, sum: String) -> Bool {
        return PersonalInfoRepository.shared.createPersonalInfo(user_id: userId,
                                                         fullName: fullName,
                                                         phoneNumber: phoneNumber,
                                                         email: email,
                                                         location: loc,
                                                         summary: sum)
    }
    
    func updatePersonalInfo(id: String, name: String, phone: String, email: String, location: String, summary: String) -> Bool {
        return PersonalInfoRepository.shared.updatePersonalInfo(id: id,
                                                                newName: name,
                                                                newPhoneNumber: phone,
                                                                newEmail: email,
                                                                newLocation: location,
                                                                newSummary: summary)
    }
    
    func deletePersonalInfo(data: Personal_Info) -> Bool {
        return PersonalInfoRepository.shared.deletePersonalInfo(data: data)
    }
}
