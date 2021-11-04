//
//  LandingPageViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class LandingPageViewModel: NSObject {
    
//    var user: User?
    var emptyStateId: EmptyState?
    let userResumeRepo = UserResumeRepository.shared
    let emptyStateRepo = EmptyStateRepository.shared
    
//    init(user: User?){
//        self.user = user
//        self.emptyStateId = emptyStateId
//    }
    
    
    func allUserResumeDataByDate() -> [User_Resume]?{
        return userResumeRepo.getAllUserResumeByDate()
    }
    
    func getUserResume() -> [User_Resume]?{
        return userResumeRepo.getAllUserResume()
    }
    
    func deleteResumeData(resume: User_Resume?) {
        let emptyResumeData = User_Resume()
        userResumeRepo.deleteUserResume(data: resume ?? emptyResumeData)
    }
    
//    func emptyStateData() -> EmptyState?{
//        return emptyStateRepo.getEmptyStateById(id: emptyStateId)
//    }

}
