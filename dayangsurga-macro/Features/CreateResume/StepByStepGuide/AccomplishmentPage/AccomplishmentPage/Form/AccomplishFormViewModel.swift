//
//  AccomplishFormViewModel.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 10/11/21.
//

import Foundation
import UIKit

class AccomplishFormViewModel {
    
    func getAccomplishSuggestion() -> Accomplishment_Suggest?{
        return AccomplishmentSuggestionRepository.shared.getAccomplishmentSuggestionById(accomSuggestId: 0)
    }
    func getAccomplishPh() -> Accomplish_Placeholder?{
        return AccomplishmentPlaceholderRepository.shared.getAccomplishmentPlaceholderById(id: 0)
    }
    
    // get data accomplishment
    func getAccomplishById(id: Int) -> Accomplishment?{
        return AccomplishmentRepository.shared.getAccomplishmentById(AccomplishmentId: id)
    }
    func deleteAccomplishData(dataAccomplish: Accomplishment?) {
        AccomplishmentRepository.shared.deleteAccomplishment(data: dataAccomplish ?? Accomplishment())
    }
    
}
