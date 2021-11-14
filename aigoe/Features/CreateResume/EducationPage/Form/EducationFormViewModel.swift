//
//  EducationFormViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 14/11/21.
//

import Foundation

class EducationFormViewModel: NSObject {
    let eduRepo = EducationRepository.shared
    let eduPhRepo = EducationPlaceholderRepository.shared
    let eduCueRepo = EducationSuggestionRepository.shared
    
    func getEduPh() -> Edu_Placeholder{
        guard let data = eduPhRepo.getEducationPlaceholderById(id: 1) else { return Edu_Placeholder() }
        return data
    }
    
    func getEduSuggest() -> Edu_Suggestion {
        guard let data = eduCueRepo.getEducationSuggestionById(id: 1) else { return Edu_Suggestion() }
        return data
    }
    
    func deleteEduData(eduData: Education) -> Bool {
        let data = eduRepo.deleteEducation(data: eduData)
        return data
    }
}
