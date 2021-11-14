//
//  SkillsFormViewModel.swift
//  aigoe
//
//  Created by Audrey Aurelia Chang on 14/11/21.
//

import Foundation

class SkillsFormViewModel: NSObject{
    
    func getSkillsById(id: Int)-> Skills?{
        return SkillRepository.shared.getSkillsById(skillId: Int32(id))
    }
    
    func getPlacehoder(id:Int)->Skills_Placeholder?{
        return SkillPlaceholderRepository.shared.getSkillPlaceholderById(id: 0)
    }
    
    func getSkillSuggestion(id: Int)-> Skills_Suggest?{
        return SkillSuggestionRepository.shared.getSkillSuggestionById(skill_suggestion_id: 0)
    }
}
