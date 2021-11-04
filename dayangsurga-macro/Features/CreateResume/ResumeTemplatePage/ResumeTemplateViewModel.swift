//
//  ResumeTemplateViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation

class ResumeTemplateViewModel: NSObject{
    
    let templateRepo = ResumeTemplateRepository.shared
    
    func getTemplate() -> [Resume_Template]?{
        return templateRepo.getAllTemplate()
    }
}
