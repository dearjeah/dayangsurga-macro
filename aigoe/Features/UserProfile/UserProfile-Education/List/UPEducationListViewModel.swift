//
//  UPEducationListViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import Foundation

class UPEducationListViewModel: NSObject {
    
    func getAllEducation() -> [Education] {
        guard let data = EducationRepository.shared.getAllEducation() else {
            return [Education]()}
        return data
    }
}
