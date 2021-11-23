//
//  ResumeTemplateViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation
import UIKit

class ResumeTemplateViewModel: NSObject{
    
    let templateRepo = ResumeTemplateRepository.shared
    let resumeRepo = ResumeContentRepository.shared
    let userResume = UserResumeRepository.shared
    
    func getTemplate() -> [Resume_Template]?{
        return templateRepo.getAllTemplate()
    }
    
    func createResumeContent() -> String {
        let id = UUID().uuidString
        resumeRepo.createResumeContent(resume_id:id, exp_id: "", edu_id: [], accom_id: [], skill_id: [])
        return id
    }
    
    func createUserResume(resumeId: String, selectedTemplate: Int) {
        userResume.createUserResume(resume_id: resumeId, template_id: selectedTemplate, user_id: 0, image: UIImage(), name: "My Resume", lastUpdate: Date(), editingProgress: 0)
    }
    
    func getCurrentUserResumeContent(id: String) -> Resume_Content{
        return resumeRepo.getResumeContentById(resume_id: id) ?? Resume_Content()
    }
    
    func getCurrentUserResume(id: String) -> User_Resume{
        return userResume.getUserResumeById(resume_id: id ) ?? User_Resume()
    }
    
    
}
