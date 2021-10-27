//
//  PreloadUserData.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 26/10/21.
//

import Foundation
import UIKit

class PreloadUserData {
    
    // preload user suggestion
    func preloadUserSuggetsion(){
        UserSuggestionRepository.shared.createUserSuggestion(user_suggestion_id: 1,
                                                             user_id: 0,
                                                             summarySuggest: "Tell us about who you are and what you do that fits the job you're applying for, make sure you use action verbs.")
    }
    
    // preload user placeholder
    func preloadUserPh() {
        UserPlaceholderRepository.shared.createUserPh(user_ph_id: 1,
                                                      user_id: 0,
                                                      name_ph: "e.g. Olipia Dayangz",
                                                      phoneNumber_ph: "e.g. 08123456789",
                                                      email_ph: "e.g. Olipia@gmail.com",
                                                      address_ph: "e.g. Jakarta, Indonesia",
                                                      summary_ph: "e.g. Highly capable Product Manager with 1+ years experience in technology companies, seeking to apply strategic planning to grow revenue and market share. ")
    }
}
