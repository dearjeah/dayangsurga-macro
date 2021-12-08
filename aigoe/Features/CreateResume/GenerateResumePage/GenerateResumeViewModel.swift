//
//  GenerateResumeViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation

class GenerateResumeViewModel {
    var resumeContentRepo = ResumeContentRepository.shared
    let resumeRepo = UserResumeRepository.shared
    
    func getResumeContentData(resumeId: String) -> Resume_Content {
        let data = resumeContentRepo.getResumeContentById(resume_id: resumeId) ?? Resume_Content()
        return data
    }
    func updateResumeName(resume_id: String, resumeName: String)->Bool{
        let data = resumeRepo.updateResumeName(resume_id: resume_id, newResumeName: resumeName)

        return data
    }
}
