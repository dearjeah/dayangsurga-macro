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
    
    func createResumeContent(resumeId: String) -> String {
        resumeRepo.createResumeContent(resume_id: resumeId, exp_id: [], edu_id: [], accom_id: [], skill_id: [])
        let data = resumeRepo.getResumeContentById(resume_id: resumeId)
        let contentId = data?.resume_id ?? ""
        return contentId
    }
    
    func createUserResume(selectedTemplate: Int) -> String {
        let id = UUID().uuidString
        userResume.createUserResume(resume_id: id, template_id: selectedTemplate, user_id: 0, image: UIImage(), name: "My Resume", lastUpdate: Date(), editingProgress: 0)
        return id
    }
    
    func getCurrentUserResumeContent(id: String) -> Resume_Content{
        return resumeRepo.getResumeContentById(resume_id: id) ?? Resume_Content()
    }
    
    func getCurrentUserResume(id: String) -> User_Resume{
        return userResume.getUserResumeById(resume_id: id ) ?? User_Resume()
    }
    
    
}
