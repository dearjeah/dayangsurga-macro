//
//  PersonalInfoViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation

class PersonalInfoViewModel: NSObject {
    let personalInfoRepo = PersonalInfoRepository.shared
    let resumeContentRepo = ResumeContentRepository.shared
    
    func getPersonalInfoDataById(personalInfoId: String) -> Personal_Info {
        guard let data = personalInfoRepo.getPersonalInfoById(id: personalInfoId) else { return Personal_Info() }
        return data
    }
    
    func getAllPersonalInfoData() -> [Personal_Info] {
        guard let data = personalInfoRepo.getAllPersonalInfo() else { return []}
        return data
    }
    
    func updatePersonalInfo(id: String, name: String, phone: String, email: String, location: String, summary: String) {
       let data = personalInfoRepo.updatePersonalInfo(id: id, newName: name, newPhoneNumber: phone, newEmail: email, newLocation: location, newSummary: summary)
    }
    func addSelectedPersonalInfo(resumeId: String, personalInfoId: String) {
        resumeContentRepo.updateResumeContentPersonalInfo(resume_id: resumeId, newPersonal_id: personalInfoId)
    }
    func deleteSelectedPersonalInfo(resumeId: String, personalInfoId: String) {
        let data = resumeContentRepo.deleteResumeContentPersonalInfo(resume_id: resumeId, personalInfoId: personalInfoId)
    }
}

struct PersonalInformationPlaceholder {
    let fullName, email, phoneNumber, location, summary : String
}

