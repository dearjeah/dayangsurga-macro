//
//  EducationListViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 14/11/21.
//

import Foundation

class EducationListViewModel: NSObject {
    let eduRepo = EducationRepository.shared
    let resumeContentRepo = ResumeContentRepository.shared
    
    func getEduData() -> [Education] {
        guard let data = eduRepo.getAllEducation() else {return [Education]()}
        
        return data
    }
    
    func addSelectedEdu(resumeId: String, eduId: String) {
        resumeContentRepo.updateResumeContentEdu(resume_id: resumeId, newEdu_id: eduId)
    }
    
    func removeUnselectedEdu(resumeId: String, eduId: String) {
        let isSuccess = resumeContentRepo.deleteResumeContentEdu(resume_id: resumeId, eduId: eduId)
    }
}
