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
    
    // for experience
    func getExpByIndex(id: Int) -> Experience?{
        return expRepo.getExperienceById(experienceId: id)
    }
    
    func addExpData(title: String, jobDesc: String, company: String, startDate: Date, endDate: Date, status: Bool, isSelected: Bool) -> Bool {
        let addExp = expRepo.createExperience(exp_id: 1001, //nanti ganti ke uuid().uuidString
                                 user_id: 0,
                                 jobTitle: title,
                                 jobDesc: jobDesc,
                                 jobCompanyName: company,
                                 jobStartDate: startDate,
                                 jobEndtDate: endDate,
                                 jobStatus: status,
                                 isSelected: isSelected)
        return addExp
    }
    
    func updateExpData(title: String, jobDesc: String, company: String, startDate: Date, endDate: Date, status: Bool, isSelected: Bool) -> Bool {
        let updateExp = expRepo.createExperience(exp_id: 1001, //nanti ganti ke uuid().uuidString
                                 user_id: 0,
                                 jobTitle: title,
                                 jobDesc: jobDesc,
                                 jobCompanyName: company,
                                 jobStartDate: startDate,
                                 jobEndtDate: endDate,
                                 jobStatus: status,
                                 isSelected: isSelected)
        return updateExp
    }

    
    func deleteExpData(dataExperience: Experience?) -> Bool {
        let data = expRepo.deleteExperience(data: dataExperience ?? Experience())
        return data
    }

}
