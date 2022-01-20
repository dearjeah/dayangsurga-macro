//
//  UPSkillFormViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import Foundation

class UPSkillFormViewModel: NSObject {
    func getSkillsById(id: String)-> Skills?{
        return SkillRepository.shared.getSkillsById(skillId: id)
    }
    
    func getPlacehoder(id:Int)->Skills_Placeholder?{
        return SkillPlaceholderRepository.shared.getSkillPlaceholderById(id: 0)
    }
    
    func getSkillSuggestion(id: Int)-> Skills_Suggest?{
        return SkillSuggestionRepository.shared.getSkillSuggestionById(skill_suggestion_id: 0)
    }
    
    func getSkillData() -> [Skills]?{
        return SkillRepository.shared.getAllSkill()
    }
    
    func createSkill(userId: String, skillId: String, skillName: String, isSelected: Bool)-> Bool{
        let skill = SkillRepository.shared.createSkill(skillId: skillId, userId: userId, skillName: skillName, isSelected: isSelected)
        return skill
    }
    
    func updateSkill(skillId: String, skillName: String, isSelected: Bool)-> Bool{
        let skill = SkillRepository.shared.updateSkill(skillId: skillId, skillName: skillName, isSelected: isSelected)
        return skill
    }
    
    func deleteSkill(skill: Skills) -> Bool{
        let skill = SkillRepository.shared.deleteSkills(data: skill)
        return skill
    }
}
