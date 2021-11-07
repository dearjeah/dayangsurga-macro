//
//  ExperienceFormViewModel.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 06/11/21.
//

import Foundation
import UIKit

class ExperienceFormViewModel: NSObject{
    
    let expSuggestionRepo = ExperienceSuggestionRepository.shared
    let expPhRepo = ExperiencePlaceholderRepository.shared
    let expRepo = ExperienceRepository.shared
    
    
    // for experience suggestion + ph
    func getExpSuggestion() -> Experience_Suggestion?{
        return expSuggestionRepo.getExpSuggestionById(exp_suggest_id: 1)
    }
    
    func getExpPh() -> Experience_Placeholder?{
        return expPhRepo.getExpPhById(id: 1)
    }
    
    func getAllExpPh() -> [Experience_Placeholder]?{
        return expPhRepo.getAllExpPh()
    }

}
