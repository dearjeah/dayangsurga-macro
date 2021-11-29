//
//  GenerateResumeViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation

class GenerateResumeViewModel: NSObject {
    let resumeRepo = UserResumeRepository.shared
    
    func updateResumeName(resume_id: String, resumeName: String)->Bool{
        let data = resumeRepo.updateResumeName(resume_id: resume_id, newResumeName: resumeName)

        return data
    }
}
