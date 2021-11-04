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
//    let imageData1 = img1.pngData()! as NSData
//    let data1 = imageData1.base64EncodedData(options: .lineLength64Characters)
    
    let img2 = UIImage.imgResumeTemplateGeorgia
//    let imageData2 = img2.pngData()! as NSData
//    let data2 = imageData2.base64EncodedData(options: .lineLength64Characters)
    
    let img3 = UIImage.imgResumeTemplateHeletvica
//    let imageData3 = img3.pngData()! as NSData
//    let data3 = imageData3.base64EncodedData(options: .lineLength64Characters)
    
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
