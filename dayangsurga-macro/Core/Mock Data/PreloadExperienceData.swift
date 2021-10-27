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
                                                                  jobDescSuggest: "Describe what you have done before that matches with the job qualifications, make sure you use action verbs.")
    }
    
    // preload exp placeholder
    func preloadExpPh() {
        ExperiencePlaceholderRepository.shared.createExpPh(exp_ph_id: 1,
                                                           exp_id: 0,
                                                           jobTitle_Ph: "e.g. Apple Inc",
                                                           jobDesc_ph: "e.g. Project Manager",
                                                           companyName_ph: "Lead a new CLOAD application project with a team of 5 people focusing on ATS-friendly resume.")
    }
}
