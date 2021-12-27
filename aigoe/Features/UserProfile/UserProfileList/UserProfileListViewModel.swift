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
            UserProfileList(img: UserProfileType.personal.getImage(), title: UserProfileType.personal.getTitle()),
            UserProfileList(img: UserProfileType.education.getImage(), title: UserProfileType.education.getTitle()),
            UserProfileList(img: UserProfileType.experience.getImage(), title: UserProfileType.experience.getTitle()),
            UserProfileList(img: UserProfileType.skill.getImage(), title: UserProfileType.skill.getTitle()),
            UserProfileList(img: UserProfileType.achievement.getImage(), title: UserProfileType.achievement.getTitle())
        ]
        
        return data
    }
}
