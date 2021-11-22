//
//  SkillsPageviewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 16/11/21.
//

import Foundation

class SkillsPageviewModel: NSObject {
    let skillRepo = SkillRepository.shared
    
    func getAllSkillData() -> [Skills]?{
        return skillRepo.getAllSkill()
    }
}
