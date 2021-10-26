//
//  PreloadExperienceData.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 26/10/21.
//

import Foundation
import UIKit

class PreloadExperienceData {
    
    // preload exp suggestion
    func preloadExpSuggetsion(){
        ExperienceSuggestionRepository.shared.createExpSuggestion(exp_suggest_id: 1,
                                                                  exp_id: 0,
                                                                  jobDescSuggest: "")
    }
    
    // preload exp placeholder
    func preloadExpPh() {
        ExperiencePlaceholderRepository.shared.createExpPh(exp_ph_id: 1,
                                                           exp_id: 0,
                                                           jobTitle_Ph: "",
                                                           jobDesc_ph: "",
                                                           companyName_ph: "")
    }
}
