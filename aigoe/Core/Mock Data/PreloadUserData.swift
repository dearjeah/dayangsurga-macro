//
//  PreloadUserData.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 26/10/21.
//

import Foundation
import UIKit

class PreloadUserData {
    
    //create user
    func preloadInitialUser(){
        UserRepository.shared.createUser(
            user_id: UUID().uuidString,
            username: "",
            email: "",
            password: ""
        )
    }
    
    // preload user suggestion
    func preloadUserSuggession(){
        PersonalInformationSuggestionRepository.shared.createPISuggestion(pi_suggestion_id: 1,
                                                             summarySuggest: "Tell us about who you are and what you do that fits the job you're applying for, make sure you use action verbs.")
    }
    
    // preload user placeholder
    func preloadUserPh() {
        PersonalInformationPlaceholderRepository.shared.createUserPh(pi_ph_id: 1,
                                                      user_id: 0,
                                                      name_ph: "e.g. Jane Doe",
                                                      phoneNumber_ph: "e.g. 081234567XXX",
                                                      email_ph: "e.g.  jane_doe@xxxmail.com",
                                                      address_ph: "e.g. Jakarta, Indonesia",
                                                      summary_ph: "e.g. Highly capable Product Manager with 1+ years experience in technology companies, seeking to apply strategic planning to grow revenue and market share. ")
    }
}
