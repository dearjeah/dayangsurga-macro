//
//  AccomplishmentPageViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 15/11/21.
//

import Foundation

class AccomplishmentPageViewModel: NSObject {
    
    let accompRepo = AccomplishmentRepository.shared
    
    func getAllAccomp() -> [Accomplishment] {
        let data = accompRepo.getAllAccomplishment() ?? []
        
        return data
    }
}
