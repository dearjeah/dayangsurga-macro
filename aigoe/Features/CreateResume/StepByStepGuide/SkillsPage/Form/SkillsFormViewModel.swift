//
//  SkillsFormViewModel.swift
//  aigoe
//
//  Created by Audrey Aurelia Chang on 14/11/21.
//

import Foundation

class SkillsFormViewModel: NSObject{
    
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
    
    func createSkill(skillId: String, skillName: String, isSelected: Bool)-> Bool{
        let skill = SkillRepository.shared.createSkill(skillId: skillId, userId: 0, skillName: skillName, isSelected: isSelected)
        return skill
    }
    
    func updateSkill(skillId: String, skillName: String, isSelected: Bool)-> Bool{
        let skill = SkillRepository.shared.updateSkill(skillId: skillId, userId: 0, skillName: skillName, isSelected: isSelected)
        return skill
    }
    
    func deleteSkill(skill: Skills){
        let skillToDelete = Skills()
        SkillRepository.shared.deleteSkills(data: skill )
    }

}
