//
//  PreloadSkillData.swift
//  aigoe
//
//  Created by Audrey Aurelia Chang on 15/11/21.
//

import Foundation

func preloadSkillSuggestion(){
    SkillSuggestionRepository.shared.createSkillSuggestion(skillId: UUID().uuidString, skillSuggestionId: 0, skillSuggest: "Tell us about your technical skills required in the job you’re applying for.")
}
// placeholder
func preloadSkillPh(){
    SkillPlaceholderRepository.shared.createSkillPlaceholder(skillId: UUID().uuidString, skillPlaceholderId: 0, skillPlaceholderName: "e.g. Java")
}
