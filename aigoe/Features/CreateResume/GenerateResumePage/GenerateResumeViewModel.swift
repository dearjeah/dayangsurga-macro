//
//  GenerateResumeViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation

class GenerateResumeViewModel {
    var resumeContentRepo = ResumeContentRepository.shared
    
    func getResumeContentData(resumeId: String) -> Resume_Content {
        let data = resumeContentRepo.getResumeContentById(resume_id: resumeId) ?? Resume_Content()
        return data
    }
}
