//
//  UPAchievementListViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import Foundation

class UPAchievementListViewModel: NSObject {
    let achievmentRepo = AccomplishmentRepository.shared
    
    func getAllAchievement() -> [Accomplishment] {
        let data = achievmentRepo.getAllAccomplishment() ?? []
        
        return data
    }
}
