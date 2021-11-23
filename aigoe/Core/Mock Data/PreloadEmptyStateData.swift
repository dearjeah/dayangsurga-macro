//
//  PreloadEmptyStateData.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 26/10/21.
//

import Foundation
import UIKit
    
func preloadEmptyState(){
    // landing page
    EmptyStateRepository.shared.createEmptyState(emptyState_id: 0,
                                                 image: UIImage.imgEmptyStateLandingPage,
                                                 title: "You haven’t created any resume yet. Click the ‘Create Resume’ button to start creating resume.")
    //education
    EmptyStateRepository.shared.createEmptyState(emptyState_id: 1,
                                                 image: UIImage.imgEmptyStateEdu,
                                                 title: "You haven’t filled your educational history. Click the ‘Add’ button to add your education information.")
    // experience
    EmptyStateRepository.shared.createEmptyState(emptyState_id: 2,
                                                 image: UIImage.imgExpEmptyState,
                                                 title: "You haven’t filled your professional experience. Click the ‘Add’ button to add your professional experience.")
    // skills
    EmptyStateRepository.shared.createEmptyState(emptyState_id: 3,
                                                 image: UIImage.imgSkillEmptyState,
                                                 title: "You haven’t added any skills. Click the ‘Add’ button to add your technical skills.")
    // accomplishment
    EmptyStateRepository.shared.createEmptyState(emptyState_id: 4,
                                                 image: UIImage.imgEmptyStateAccom,
                                                 title: "You haven't added any of your accomplishment. Click the ‘Add’ button to add your certificates or awards.")
    // personal information
    EmptyStateRepository.shared.createEmptyState(emptyState_id: 5,
                                                 image: UIImage.imgPersonalInformationEmptyState,
                                                 title: "You haven't filled your personal information yet. Click the ‘Add’ button to add your personal information")
}


