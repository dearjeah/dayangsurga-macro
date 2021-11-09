//
//  PreloadExpertData.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 09/11/21.
//

import Foundation
import UIKit

func preloadExpertProfile(){
    // experience in year
    // note di entity: avail time, expertise
    // di notion: title on list, background image, summary
    ExpertProfileRepository.shared.createExpertProfile(expertId: 0,
                                                       name: "Dara",
                                                       experience: 1,
                                                       expertise: "",
                                                       phoneNumber: "087838448246",
                                                       availTime: "",
                                                       linkedIn: "https://www.linkedin.com/in/dara-anggitasari-7371011b8",
                                                       image: UIImage(named: "imgExpertDara") ?? UIImage())
    ExpertProfileRepository.shared.createExpertProfile(expertId: 1,
                                                       name: "Fahri Al Irsyad",
                                                       experience: 3,
                                                       expertise: "",
                                                       phoneNumber: "085881056414",
                                                       availTime: "",
                                                       linkedIn: "https://www.linkedin.com/in/fahriasen",
                                                       image: UIImage(named: "imgExpertFahri") ?? UIImage())
    ExpertProfileRepository.shared.createExpertProfile(expertId: 2,
                                                       name: "Rasyid Wardianto",
                                                       experience: 4,
                                                       expertise: "",
                                                       phoneNumber: "081227880967",
                                                       availTime: "",
                                                       linkedIn: "https://www.linkedin.com/in/muhammad-rosyid-wardianto-945830177",
                                                       image: UIImage(named: "imgExpertRasyid") ?? UIImage())
    ExpertProfileRepository.shared.createExpertProfile(expertId: 3,
                                                       name: "Romano Giri Permana",
                                                       experience: 1,
                                                       expertise: "",
                                                       phoneNumber: "089503558536",
                                                       availTime: "",
                                                       linkedIn: "https://www.linkedin.com/in/romanogiripermana",
                                                       image: UIImage(named: "imgExpertRomano") ?? UIImage())
    ExpertProfileRepository.shared.createExpertProfile(expertId: 4,
                                                       name: "Nashtiti",
                                                       experience: Int32(1.5),
                                                       expertise: "",
                                                       phoneNumber: "082138565635",
                                                       availTime: "",
                                                       linkedIn: "https://www.linkedin.com/in/nashtitialiafari",
                                                       image: UIImage(named: "imgExpertNashtiti") ?? UIImage())
    ExpertProfileRepository.shared.createExpertProfile(expertId: 5,
                                                       name: "Maria Denta",
                                                       experience: 3,
                                                       expertise: "",
                                                       phoneNumber: "081380245065",
                                                       availTime: "",
                                                       linkedIn: "https://www.linkedin.com/in/maria-denta-putri-b73368159",
                                                       image: UIImage(named: "imgExpertMaria") ?? UIImage())
    ExpertProfileRepository.shared.createExpertProfile(expertId: 6,
                                                       name: "Utari Hastrarini",
                                                       experience: Int32(2.5),
                                                       expertise: "",
                                                       phoneNumber: "088218032081",
                                                       availTime: "",
                                                       linkedIn: "https://www.linkedin.com/in/utarihastra",
                                                       image: UIImage(named: "imgExpertDyah") ?? UIImage())
}
