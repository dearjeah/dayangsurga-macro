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
    func getAccomplishById(id: String) -> Accomplishment?{
        return AccomplishmentRepository.shared.getAccomplishmentById(AccomplishmentId: id)
    }
    
    func addAccomp(title: String, givenDate: Date, endDate: Date, status: Bool, issuer: String, desc: String, userId: String) -> Bool {
        let data = accompRepo.createAccomplishment(
            accomId: UUID().uuidString,
            userId: userId,
            title: title,
            givenDate: givenDate,
            endDate: endDate,
            status: status,
            issuer: issuer,
            desc: desc,
            isSelected: true
        )
        return data
    }
    
    func updateAccomp(accompId: String, title: String, givenDate: Date, endDate: Date, status: Bool, issuer: String, desc: String) -> Bool {
        let data = accompRepo.updateAccomplishment(
            accomId: accompId,
            title: title,
            givenDate: givenDate,
            endDate: endDate,
            status: status,
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
