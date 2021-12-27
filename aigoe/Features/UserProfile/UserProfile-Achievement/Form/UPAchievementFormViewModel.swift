//
//  UPAchievementFormViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import Foundation

class UPAchievementFormViewModel: NSObject {
    let achievementRepo = AccomplishmentRepository.shared
    let achievementPh = AccomplishmentPlaceholderRepository.shared
    let achievementSuggest = AccomplishmentSuggestionRepository.shared
    
    func getAchievementSuggest() -> Accomplishment_Suggest?{
        return achievementSuggest.getAccomplishmentSuggestionById(accomSuggestId: 0)
    }
    
    func getAchievementPh() -> Accomplish_Placeholder?{
        return achievementPh.getAccomplishmentPlaceholderById(id: 0)
    }
    
    func getAchievementById(id: String) -> Accomplishment?{
        return achievementRepo.getAccomplishmentById(AccomplishmentId: id)
    }
    
}
