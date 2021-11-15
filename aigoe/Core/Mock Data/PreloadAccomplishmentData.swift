//
//  PreloadAccomplishmentData.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 10/11/21.
//

import Foundation
import UIKit

// suggestion
func preloadAccomplishSuggestion(){
    AccomplishmentSuggestionRepository.shared.createAccomplishmentSuggestion(accomId: 0,
                                                                             accomSuggestionId: 0,
                                                                             title: "Only include certificates or awards that are relevant to the job you're applying for.",
                                                                             desc: "")
}
// placeholder
func preloadAccomplishPh(){
    AccomplishmentPlaceholderRepository.shared.createAccomplishmentPlaceholder(accomId: 0,
                                                                               accomPlaceholderId: 0,
                                                                               titlePlaceholder: "e.g. UI/UX & Product Design",
                                                                               givenDatePlaceholder: "e.g. Dayang.co")
}

// accomplish dummy data
//func preloadAccomplish(){
//    AccomplishmentRepository.shared.createAccomplishment(accomId: 0,
//                                                         userId: 0,
//                                                         title: "App Development Swift Certification",
//                                                         givenDate: Date(),
//                                                         issuer: "Swift.co",
//                                                         desc: "",
//                                                         isSelected: true)
//}
