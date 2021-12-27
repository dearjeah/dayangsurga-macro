//
//  UserProfileListModel.swift
//  aigoe
//
//  Created by Delvina Janice on 27/12/21.
//

import Foundation
import UIKit

enum UserProfileType: String, CaseIterable {
    case personal = "Personal Info"
    case education = "Education"
    case experience = "Profesional Experience"
    case skill = "Technical Skill"
    case achievement = "Achievement"
    
    func getImage() -> UIImage {
        var img: UIImage = UIImage.icAchvFill ?? UIImage()
        switch self {
        case .personal:
            img = UIImage.icPersonFill ?? UIImage()
            return img
        case .education:
            img = UIImage.icEduFill ?? UIImage()
            return img
        case .experience:
            img = UIImage.icExpFill ?? UIImage()
            return img
        case .skill:
            img = UIImage.icSkillFill ?? UIImage()
            return img
        case .achievement:
            img = UIImage.icAchvFill ?? UIImage()
            return img
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .personal:
            return "Personal Info"
        case .education:
            return "Education"
        case .experience:
            return "Profesional Experience"
        case .skill:
            return "Technical Skill"
        case .achievement:
            return "Achievement"
        }
    }
}

struct UserProfileList {
    var img: UIImage
    var title: String
    
    init(img: UIImage, title: String) {
        self.img = img
        self.title = title
    }
}
