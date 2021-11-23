//
//  PreloadEducationData.swift
//  aigoe
//
//  Created by Delvina Janice on 14/11/21.
//

import Foundation

extension CoreDataManager {
    func preloadEduPlaceholder() {
        EducationPlaceholderRepository.shared.createEducationPlaceholder(
            eduId: UUID().uuidString,
            eduPlaceholderId: 1,
            institutionPlaceholder: "e.g. Aigoe University",
            titlePlaceholder: "e.g. Bachelor of Computer Science",
            gpaPlaceholder: "e.g. 3.90",
            activityPlaceholder: "Group leader of Smart City application project. College Student of the year awarded by Aigoe University.",
            startDatePlaceholder: "",
            endDatePlaceholder: ""
        )
    }
    
    func preloadEduSuggestion() {
        EducationSuggestionRepository.shared.createEducationSuggestion(
            eduId: UUID().uuidString,
            eduSuggestionId: 1,
            activitySuggestion: "To show experiences or skills you want to highlight, consider including relevant projects or activities that align with the job qualifications."
        )
    }
}
