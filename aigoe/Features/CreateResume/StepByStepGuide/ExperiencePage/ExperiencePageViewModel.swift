//
//  ExperiencePageViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 14/11/21.
//

import Foundation

class ExperiencePageViewModel: NSObject{
    let experienceRepo = ExperienceRepository.shared
    
    func getAllExpData() -> [Experience]?{
        return experienceRepo.getAllExperience()
    }
}
