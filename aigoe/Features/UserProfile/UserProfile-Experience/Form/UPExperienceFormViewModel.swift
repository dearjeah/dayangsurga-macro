//
//  UPExperienceFormViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import Foundation

class UPExperienceFormViewModel: NSObject {
    let expRepo = ExperienceRepository.shared
    let expPh = ExperiencePlaceholderRepository.shared
    let expSuggest = ExperienceSuggestionRepository.shared
    
    func getExpPh() -> Experience_Placeholder {
        guard let data =  expPh.getExpPhById(id: 1) else {
            return Experience_Placeholder()
        }
    return data
    }
    
    func getExpSuggest() -> Experience_Suggestion {
        guard let data = expSuggest.getExpSuggestionById(exp_suggest_id: 1) else {
            return Experience_Suggestion()
        }
    return data
    }
    
    func addExp(userId: String, expId: String, title: String, jobDesc: String, company: String, startDate: Date, endDate: Date, status: Bool, isSelected: Bool) -> Bool{
        let addExp = expRepo.createExperience(exp_id: UUID().uuidString,
                                              user_id: userId,
                                              jobTitle: title,
                                              jobDesc: jobDesc,
                                              jobCompanyName: company,
                                              jobStartDate: startDate,
                                              jobEndtDate: endDate,
                                              jobStatus: status,
                                              isSelected: true)
        return addExp
    }
    
    func deleteExp(dataExp: Experience) -> Bool {
        let deleteExp = expRepo.deleteExperience(data: dataExp)
        return deleteExp
    }
    
    func updateExp(expId: String, title: String, jobDesc: String, company: String, startDate: Date, endDate: Date, status: Bool, isSelected: Bool) -> Bool{
        let updateExp = expRepo.updateExperience(exp_id: expId,
                                                 newJobTitle: title,
                                                 newJobDesc: jobDesc,
                                                 newJobCompanyName: company,
                                                 newJobStartDate: startDate,
                                                 newJobEndtDate: endDate,
                                                 newJobStatus: status,
                                                 newIsSelected: isSelected)
        return updateExp
    }
}
