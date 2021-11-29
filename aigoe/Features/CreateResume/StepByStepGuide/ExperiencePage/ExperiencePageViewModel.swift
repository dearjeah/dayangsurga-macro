//
//  ExperiencePageViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 14/11/21.
//

import Foundation

class ExperiencePageViewModel: NSObject{
    let experienceRepo = ExperienceRepository.shared
    let resumeContentRepo = ResumeContentRepository.shared
    
    func getAllExpData() -> [Experience]?{
        return experienceRepo.getAllExperience()
    }
    
    func addSelectedExp(resumeId: String, expId: String) {
        resumeContentRepo.updateResumeContentExp(resume_id: resumeId, newExp_id: expId)
    }
    
    func removeUnselectedExp(resumeId: String, expId: String) {
        resumeContentRepo.deleteResumeContentExp(resume_id: resumeId, expId: expId)
    }
}
