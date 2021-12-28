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
    
    func addAchievement(title: String, givenDate: Date, endDate: Date, status: Bool, issuer: String, desc: String)-> Bool{
        let data = achievementRepo.createAccomplishment(
            accomId: UUID().uuidString,
            userId: 0,
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
    
    func updateAchievement(achievementId: String, title: String,givenDate: Date, endDate: Date, status: Bool, issuer: String, desc: String) -> Bool{
        let data = achievementRepo.updateAccomplishment(
            accomId: achievementId,
            userId: 0,
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
    func deleteAchievementData(dataAchievement: Accomplishment?)-> Bool{
        let data = achievementRepo.deleteAccomplishment(data: dataAchievement ?? Accomplishment())
        
        return data
    }
    
}
