//
//  AccomplishmentPageViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 15/11/21.
//

import Foundation

class AccomplishmentPageViewModel: NSObject {
    
    let accompRepo = AccomplishmentRepository.shared
    let resumeContentRepo = ResumeContentRepository.shared
    
    func getAllAccomp() -> [Accomplishment] {
        let data = accompRepo.getAllAccomplishment() ?? []
        
        return data
    }
    
    func addSelectedAccomp(resumeId: String, accomId: String) {
        resumeContentRepo.updateResumeContentAccomp(resume_id: resumeId, newAccomp_id: accomId)
    }
    
    func removeUnselectedAccomp(resumeId: String, accomId: String) {
        resumeContentRepo.deleteResumeContentAccomp(resume_id: resumeId, accompId: accomId)
    }
}
