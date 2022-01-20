//
//  UPSkillListViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import Foundation

class UPSkillListViewModel: NSObject {
    let skillRepo = SkillRepository.shared
    
    func getAllUserSkill() -> [Skills]{
        return skillRepo.getAllSkill() ?? []
    }
}
