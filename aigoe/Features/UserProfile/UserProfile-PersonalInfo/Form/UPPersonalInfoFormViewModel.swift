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
    
    func getSuggestionbyId() -> PersonalInformation_Suggestion? {
        return PersonalInformationSuggestionRepository.shared.getPISuggestionById(pi_suggestion_id: 1)
    }
}
