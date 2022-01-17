//
//  UPEducationFormViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import Foundation

class UPEducationFormViewModel: NSObject {
    
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
    
    func addEdu(userId: String, institution: String, title: String, startDate: Date, endDate: Date, gpa: String, activity: String, currentlyStudy: Bool, isSelected: Bool) -> Bool {
        let data = eduRepo.createEducation(eduId: UUID().uuidString, //ganti uuid().string nanti
                                           userId: userId,
                                           institution: institution,
                                           title: title,
                                           startDate: startDate,
                                           endDate: endDate,
                                           gpa: Float(gpa) ?? 0.0,
                                           activity: activity,
                                           currentlyStudy: currentlyStudy,
                                           isSelected: true
        )
        return data
    }
    
    func updateEdu(eduId: String, institution: String, title: String, startDate: Date, endDate: Date, gpa: String, activity: String, currentlyStudy: Bool, isSelected: Bool) -> Bool {
        let data = eduRepo.updateEducation(
            eduId: eduId,
            institution: institution,
            title: title,
            startDate: startDate,
            endDate: endDate,
            gpa: Float(gpa) ?? 0.0,
            activity: activity,
            currentlyStudy: currentlyStudy,
            isSelected: isSelected
        )
        
        return data
    }
    
    func deleteEduData(eduData: Education) -> Bool {
        let data = eduRepo.deleteEducation(data: eduData)
        return data
    }
    
}
