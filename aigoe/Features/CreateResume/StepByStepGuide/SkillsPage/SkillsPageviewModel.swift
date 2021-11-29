//
//  SkillsPageviewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 16/11/21.
//

import Foundation

class SkillsPageviewModel: NSObject {
    let skillRepo = SkillRepository.shared
    let resumeContentRepo = ResumeContentRepository.shared
    
    func getAllSkillData() -> [Skills]?{
        return skillRepo.getAllSkill()
    }
    
    func addSelectedSkill(resumeId: String, skillId: String) {
        resumeContentRepo.updateResumeContentSkill(resume_id: resumeId, newSkill_id: skillId)
    }
    
    func removeUnselectedSkill(resumeId: String, skillId: String) {
        resumeContentRepo.deleteResumeContentSkill(resume_id: resumeId, skillId: skillId)
    }
}
