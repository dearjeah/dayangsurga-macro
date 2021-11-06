//
//  LandingPageViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class LandingPageViewModel: NSObject {
    
    var emptyState: Empty_State?
    let userResumeRepo = UserResumeRepository.shared
    let emptyStateRepo = EmptyStateRepository.shared
    
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
    
    func getEmptyState() -> Empty_State?{
        return emptyStateRepo.getEmptyStateById(id: 0)
    }

}
