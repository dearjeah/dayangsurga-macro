//
//  AccomplishFormViewModel.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 10/11/21.
//

import Foundation
import UIKit

class AccomplishFormViewModel: NSObject {
    
    let accompRepo = AccomplishmentRepository.shared
    let accompPh = AccomplishmentPlaceholderRepository.shared
    let accompCue =  AccomplishmentSuggestionRepository.shared
    
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
    
    func addAccomp(title: String, givenDate: Date, issuer: String, desc: String) -> Bool {
        let data = accompRepo.createAccomplishment(
            accomId: 1001,
            userId: 0,
            title: title,
            givenDate: givenDate,
            issuer: issuer,
            desc: desc,
            isSelected: true
        )
        return data
    }
    
    func updateAccomp(accompId: Int, title: String, givenDate: Date, issuer: String, desc: String) -> Bool {
        let data = accompRepo.updateAccomplishment(
            accomId: 1001,
            userId: 0,
            title: title,
            givenDate: givenDate,
            issuer: issuer,
            desc: desc,
            isSelected: true
        )
        return data
    }
    
    func deleteAccomplishData(dataAccomplish: Accomplishment?) -> Bool{
        let data = accompRepo.deleteAccomplishment(data: dataAccomplish ?? Accomplishment())
        
        return data
    }
}
