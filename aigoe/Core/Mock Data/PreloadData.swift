//
//  PreloadData.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation

func preloadMyRessumeDummy() {
    ResumeContentRepository.shared.createResumeContent(
        resume_id: 1,
        exp_id: 0,
        edu_id: 0,
        accom_id: 0,
        skill_id: 0
    )
    
    /*EducationRepository.shared.createEducation(
        eduId: 0,
        userId: 0,
        institution: "Dayang Surga University",
        title: "Bachelor of Cheerleading",
        startDate: Date().previousDay,
        endDate: Date().nextDay,
        gpa: 4.00,
        activity: "Menyemangati yang letih, lesu, dan berbeban berat",
        currentlyStudy: false,
        isSelected: true
    )
    
    ExperienceRepository.shared.createExperience(
        exp_id: 0,
        user_id: 0,
        jobTitle: "Cheerleader",
        jobDesc: "Palugada",
        jobCompanyName: "PT Mata Gembel",
        jobStartDate: Date().previousDay,
        jobEndtDate: Date().nextDay,
        jobStatus: false,
        isSelected: true
    )*/
    
    SkillRepository.shared.createSkill(
        skillId: 0,
        userId: 0,
        skillName: "Hip Hip Hurray",
        isSelected: true
    )
    
    /*AccomplishmentRepository.shared.createAccomplishment(
        accomId: 0,
        userId: 0,
        title: "Cheerleader Terbaik 2021",
        givenDate: Date().previousDay,
        issuer: "Dayang Surga Pte Ltd",
        desc: "Pemberi semangat terbaik pada tahun 2021",
        isSelected: true
    )*/
}

/*func preloadUserResume(){
    UserResumeRepository.shared.createUserResume(resume_id: 1,
                                                 template_id: 1,
                                                 user_id: 1,
                                                 image: UIImage.imgResumeTemplateGeorgia,
                                                 name: "dfj",
                                                 lastUpdate: Date(),
                                                 editingProgress: 1)
    UserResumeRepository.shared.createUserResume(resume_id: 1,
                                                 template_id: 1,
                                                 user_id: 1,
                                                 image: UIImage.imgResumeTemplateHeletvica,
                                                 name: "abc",
                                                 lastUpdate: Date(),
                                                 editingProgress: 1)
}*/

