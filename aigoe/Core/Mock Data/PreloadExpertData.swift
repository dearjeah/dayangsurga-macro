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
    // background profile = expertise
    ExpertProfileRepository.shared.createExpertProfile(expertId: 0,
                                                       name: "Dara",
                                                       experience: "1 Year",
                                                       expertise: "HRD at Biotechnology Company",
                                                       phoneNumber: "6287838448246",
                                                       dayAvailTime: "Thursday - Friday, Saturday",
                                                       timeAvailTime: "17.00 - 19.00 (T,F), 08.00 - 11.00 (S) WIB",
                                                       linkedIn: "https://www.linkedin.com/in/dara-anggitasari-7371011b8",
                                                       image: UIImage(named: "imgExpertDara") ?? UIImage(),
                                                       titleOnList: "HRD at Biotech",
                                                       summary: "Experienced HR in start up company that responsible for recruiting non-tech position (operational) and team management with Bachelor degree in Psychology from UGM.")
    ExpertProfileRepository.shared.createExpertProfile(expertId: 1,
                                                       name: "Fahri Al Irsyad",
                                                       experience: "3 Years",
                                                       expertise: "People Development at Financial Technology Company",
                                                       phoneNumber: "6285881056414",
                                                       dayAvailTime: "Monday - Friday",
                                                       timeAvailTime: "19.00 - 21.00 WIB",
                                                       linkedIn: "https://www.linkedin.com/in/fahriasen",
                                                       image: UIImage(named: "imgExpertFahri") ?? UIImage(),
                                                       titleOnList: "People Development at Fin Tech",
                                                       summary: "Currently, I am responsible for recruiting top talent and development people. My specialties include : People Development, Recruiting, and Organizational Behavior.")
    ExpertProfileRepository.shared.createExpertProfile(expertId: 2,
                                                       name: "Rasyid Wardianto",
                                                       experience: "4 Years",
                                                       expertise: "Experienced HR at Farm Technology Company",
                                                       phoneNumber: "6281227880967",
                                                       dayAvailTime: "Monday - Friday",
                                                       timeAvailTime: "09.00 - 15.00 WIB",
                                                       linkedIn: "https://www.linkedin.com/in/muhammad-rosyid-wardianto-945830177",
                                                       image: UIImage(named: "imgExpertRasyid") ?? UIImage(),
                                                       titleOnList: "HR at Startup",
                                                       summary: "Human Resources Officer with a demonstrated history of working in the farming industry. Skilled in Public Speaking, English, SPSS, Analytical Hierarchy Process, Business Partnership, and Digital Photography.")
    ExpertProfileRepository.shared.createExpertProfile(expertId: 3,
                                                       name: "Romano Giri Permana",
                                                       experience: "1 Year",
                                                       expertise: "HRGA at Biotechnology Company",
                                                       phoneNumber: "6289503558536",
                                                       dayAvailTime: "Friday, Saturday - Sunday",
                                                       timeAvailTime: "18.00 - 21.00 (F), 09.00 - 12.00 WIB",
                                                       linkedIn: "https://www.linkedin.com/in/romanogiripermana",
                                                       image: UIImage(named: "imgExpertRomano") ?? UIImage(),
                                                       titleOnList: "HRGA at Biotechnology",
                                                       summary: "I am an HRGA at startup company that experienced in handling office supplies and recruiting marketing and sales position with Bachelor in Management.")
    ExpertProfileRepository.shared.createExpertProfile(expertId: 4,
                                                       name: "Nashtiti",
                                                       experience: "1.5 Years",
                                                       expertise: "People & Operation at Education Technology Company",
                                                       phoneNumber: "6282138565635",
                                                       dayAvailTime: "Tuesday, Wednesday, Friday",
                                                       timeAvailTime: "18.30 - 19.30 WIB",
                                                       linkedIn: "https://www.linkedin.com/in/nashtitialiafari",
                                                       image: UIImage(named: "imgExpertNashtiti") ?? UIImage(),
                                                       titleOnList: "PO at Edu Tech",
                                                       summary: "Experienced HR that skilled in end to end people operation process in education technology company and passionate about people, education, technology, start-up environment, and non-profit organization.")
    ExpertProfileRepository.shared.createExpertProfile(expertId: 5,
                                                       name: "Maria Denta",
                                                       experience: "3 Years",
                                                       expertise: "Experienced HR at Corporate and Startup Company",
                                                       phoneNumber: "6281380245065",
                                                       dayAvailTime: "Tuesday - Thursday",
                                                       timeAvailTime: "13.00 -14.00 & 17.00 - 19.00 WIB",
                                                       linkedIn: "https://www.linkedin.com/in/maria-denta-putri-b73368159",
                                                       image: UIImage(named: "imgExpertMaria") ?? UIImage(),
                                                       titleOnList: "HR Practitioner",
                                                       summary: "HR enthusiast, experienced in end to end recruitment, training, performance appraisal, personnel administration, compensation and benefit.")
    ExpertProfileRepository.shared.createExpertProfile(expertId: 6,
                                                       name: "Utari Hastrarini",
                                                       experience: "2.5 Years",
                                                       expertise: "Experienced HR at AI and Biotechnology Company",
                                                       phoneNumber: "6288218032081",
                                                       dayAvailTime: "Monday - Sunday",
                                                       timeAvailTime: "14.00 - 16.00 WIB",
                                                       linkedIn: "https://www.linkedin.com/in/utarihastra",
                                                       image: UIImage(named: "imgExpertDyah") ?? UIImage(),
                                                       titleOnList: "HR at Startup",
                                                       summary: "HR Practitioner with a demonstrated history of working in the technology industry with significant exposure to startup culture. Skilled in recruitment, administration, and communication.")
}
