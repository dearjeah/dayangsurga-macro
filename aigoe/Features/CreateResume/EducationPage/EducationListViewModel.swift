//
//  EducationListViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 14/11/21.
//

import Foundation

class EducationListViewModel: NSObject {
    let eduRepo = EducationRepository.shared
    
    func getEduData() -> [Education] {
        guard let data = eduRepo.getAllEducation() else {return [Education]()}
        
        return data
    }
}
