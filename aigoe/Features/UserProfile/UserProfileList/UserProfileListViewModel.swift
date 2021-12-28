//
//  UserProfileListViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 27/12/21.
//

import Foundation

class UserProfileListViewModel: NSObject {
    func getUserProfileList() -> [UserProfileList] {
        let data = [
            UserProfileList(img: UserProfileType.personal.getImage(), title: UserProfileType.personal.getTitle(), type: .personal),
            UserProfileList(img: UserProfileType.education.getImage(), title: UserProfileType.education.getTitle(), type: .education),
            UserProfileList(img: UserProfileType.experience.getImage(), title: UserProfileType.experience.getTitle(), type: .experience),
            UserProfileList(img: UserProfileType.skill.getImage(), title: UserProfileType.skill.getTitle(), type: .skill),
            UserProfileList(img: UserProfileType.achievement.getImage(), title: UserProfileType.achievement.getTitle(), type: .achievement)
        ]
        
        return data
    }
}
