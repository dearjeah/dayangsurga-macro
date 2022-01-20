//
//  UPExperienceListViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import Foundation

class UPExperienceListViewModel: NSObject {
    
    func getAllExperience() -> [Experience] {
        guard let data =  ExperienceRepository.shared.getAllExperience() else {
            return [Experience]()}
    return data
    }
}
