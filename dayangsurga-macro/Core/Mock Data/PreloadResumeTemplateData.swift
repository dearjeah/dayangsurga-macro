//
//  PreloadResumeTemplateData.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 04/11/21.
//

import Foundation
import UIKit

func preloadResumeTemplate(){
    let img1 = UIImage.imgResumeTemplateArial
    let img2 = UIImage.imgResumeTemplateGeorgia
    let img3 = UIImage.imgResumeTemplateHeletvica
    
    ResumeTemplateRepository.shared.createResumeTemplate(template_id: 0,
                                                         image: img1,
                                                         name: "ResumeTemplateArial")
    ResumeTemplateRepository.shared.createResumeTemplate(template_id: 1,
                                                         image: img2,
                                                         name: "ResumeTemplateGeorgia")
    ResumeTemplateRepository.shared.createResumeTemplate(template_id: 2,
                                                         image: img3,
                                                         name: "ResumeTemplateHeletvica")
}
