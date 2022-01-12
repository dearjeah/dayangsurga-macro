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
    let resumeContentRepo = ResumeContentRepository.shared
    
    // for experience suggestion + ph
    func getExpSuggestion() -> Experience_Suggestion?{
        return expSuggestionRepo.getExpSuggestionById(exp_suggest_id: 1)
    }
    func getExpPh() -> Experience_Placeholder?{
        return expPhRepo.getExpPhById(id: 1)
    }
    
    // for experience
    func getExpByIndex(id: String) -> Experience?{
        return expRepo.getExperienceById(experienceId: id)
    }
    
    func addExpData(userId: String, title: String, jobDesc: String, company: String, startDate: Date, endDate: Date, status: Bool, isSelected: Bool) -> Bool {
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
    
    func updateExpData(expId: String, title: String, jobDesc: String, company: String, startDate: Date, endDate: Date, status: Bool, isSelected: Bool) -> Bool {
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
    
    func deleteExpData(dataExperience: Experience?) -> Bool {
        let data = expRepo.deleteExperience(data: dataExperience ?? Experience())
        return data
    }
    
    //resume content
    func addExpToResumeContent(resumeId: String, expId: String) {
        resumeContentRepo.updateResumeContentExp(resume_id: resumeId, newExp_id: expId)
    }
    
    func removeExpFromoResumeContent(resumeId: String, expId: String) {
        resumeContentRepo.deleteResumeContentExp(resume_id: resumeId, expId: expId)
    }

}
