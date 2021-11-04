//
//  PreloadResumeTemplateData.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 04/11/21.
//

import Foundation
import UIKit

func preloadResumeTemplate(){
    
    
    ResumeTemplateRepository.shared.createResumeTemplate(template_id: 1,
                                                         image: Data(),
                                                         name: "ResumeTemplateArial")
    ResumeTemplateRepository.shared.createResumeTemplate(template_id: 2,
                                                         image: Data(),
                                                         name: "ResumeTemplateGeorgia")
    ResumeTemplateRepository.shared.createResumeTemplate(template_id: 3,
                                                         image: Data(),
                                                         name: "ResumeTemplateHeletvica")
}
