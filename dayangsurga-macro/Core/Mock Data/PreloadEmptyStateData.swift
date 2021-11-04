//
//  PreloadEmptyStateData.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 26/10/21.
//

import Foundation
import UIKit


    
    func preloadEmptyState(){
        EmptyStateRepository.shared.createEmptyState(emptyState_id: 1,
                                                     image: Data(),
                                                     title: "You haven’t made any resume, yet. Click the ‘Create Resume’ button to start creating resume.")
        EmptyStateRepository.shared.createEmptyState(emptyState_id: 2,
                                                     image: Data(),
                                                     title: "You haven’t filled your educational history. Click the ‘Add’ button to add your educational information.")
        EmptyStateRepository.shared.createEmptyState(emptyState_id: 3,
                                                     image: Data(),
                                                     title: "You haven’t filled your professional experience. Click the ‘Add’ button to add your professional experience.")
        EmptyStateRepository.shared.createEmptyState(emptyState_id: 4,
                                                     image: Data(),
                                                     title: "You haven’t filled your skills. Click the ‘Add’ button to add your technical skills.")
        EmptyStateRepository.shared.createEmptyState(emptyState_id: 5,
                                                     image: Data(),
                                                     title: "You have no accomplishment yet. Click the ‘Add’ button to add your certificates or awards.")
        EmptyStateRepository.shared.createEmptyState(emptyState_id: 6,
                                                     image: Data(),
                                                     title: "You have no personal information yet. Click the ‘Add’ button to add your personal information")
    }
    
let imgObj = UIImage.imgEmptyStateLandingPage
let imageData = imgObj.pngData()! as NSData
let base64 = imageData.base64EncodedData(options: .lineLength64Characters)

    func preloadUserResume(){
        UserResumeRepository.shared.createUserResume(resume_id: 1,
                                                     template_id: 1,
                                                     user_id: 1,
                                                     image: imageData as Data,
                                                     name: "dfj",
                                                     lastUpdate: Date(),
                                                     editingProgress: 2)
        UserResumeRepository.shared.createUserResume(resume_id: 2,
                                                     template_id: 1,
                                                     user_id: 1,
                                                     image: imageData as Data,
                                                     name: "abc",
                                                     lastUpdate: Date(),
                                                     editingProgress: 3)
    }

