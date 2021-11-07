//
//  StepByStepGuideViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class StepByStepGuideViewModel: NSObject {
//    override init() {
//
//    }
    let experienceRepo = ExperienceRepository.shared
    let emptyStateRepo = EmptyStateRepository.shared
    
    // for empty state
    func getEmptyStateId(Id: Int) -> Empty_State?{
        return emptyStateRepo.getEmptyStateById(id: Id)
    }
    
    // for experience
    func getExpData() -> [Experience]?{
        return experienceRepo.getAllExperience()
    }
    
    func deleteExpData(experience: Experience?){
        let expData = Experience()
        experienceRepo.deleteExperience(data: experience ?? expData)
    }
    
}
