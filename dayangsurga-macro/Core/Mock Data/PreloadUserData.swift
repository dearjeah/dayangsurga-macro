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
                                                             summarySuggest: "")
    }
    
    // preload user placeholder
    func preloadUserPh() {
        UserPlaceholderRepository.shared.createUserPh(user_ph_id: 1,
                                                      user_id: 0,
                                                      name_ph: "",
                                                      phoneNumber_ph: "",
                                                      email_ph: "",
                                                      address_ph: "",
                                                      summary_ph: "")
    }
}
