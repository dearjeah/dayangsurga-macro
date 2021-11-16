//
//  StepByStepGuideViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

enum progressBarType {
    case personal
    case education
    case expQuiz
    case exp
    case skillQuiz
    case skill
    case accomQuiz
    case accom
}

class StepByStepGuideViewModel: NSObject {
    
    let emptyStateRepo = EmptyStateRepository.shared
    let userRepo = UserRepository.shared
    let experienceRepo = ExperienceRepository.shared
    let eduRepo = EducationRepository.shared
    let skillRepo = SkillRepository.shared
    let accomRepo = AccomplishmentRepository.shared
    let userResumeContent = UserResumeRepository.shared

    // for empty state
    func getEmptyStateId(Id: Int) -> Empty_State?{
        return emptyStateRepo.getEmptyStateById(id: Id)
    }
    
    // for experience
    func getExpData() -> [Experience]?{
        return experienceRepo.getAllExperience()
    }
    
    func getExpByIndex(expId: String) -> Experience?{
        return experienceRepo.getExperienceById(experienceId: expId)
    }
    
    // for accomplishment
    func getAccomplishData() -> [Accomplishment]?{
        return AccomplishmentRepository.shared.getAllAccomplishment()
    }
    
    func getAccomplishByIndex(accomplishId: String) -> Accomplishment?{
        return AccomplishmentRepository.shared.getAccomplishmentById(AccomplishmentId: accomplishId)
    }

    func getAllInitialData() -> (edu: [Education], exp: [Experience], skill: [Skills], accom: [Accomplishment]){
        let eduData = eduRepo.getAllEducation() ?? []
        let expData = experienceRepo.getAllExperience() ?? []
        let skillData = skillRepo.getAllSkill() ?? []
        let accomData = accomRepo.getAllAccomplishment() ?? []
        
        return (eduData, expData, skillData, accomData)
    }
    
    func getSkillData() -> [Skills]?{
        return SkillRepository.shared.getAllSkill()
    }
    
    func getSkillByIndex(skillId: String) -> Skills?{
        return SkillRepository.shared.getSkillsById(skillId: skillId)
    }
    
    
    func updatePersonalInfo(data: PersonalInfo) {
        userRepo.updateUser(id: 0,
                            newName: data.name,
                            newPhoneNumber: data.phoneNumber,
                            newEmail: data.email,
                            newLocation: data.location,
                            newSummary: data.summary
        )
    }
    
    func updateSelectedEduToResume() {
        
    }
    
    func updateSelectedExpToResume() {
        
    }
    
    func updateSelectedSkillsToResume() {
        
    }
    
    func updateSelectedAccompToResume() {
        
    }
}

//MARK: Progress Bar
extension StepByStepGuideViewModel {
    func updateImage(progress: progressBarType, progressBarView: ProgressBarView) {
        switch progress {
        case .personal:
            personalProgressSelectedImage(progressBarView: progressBarView)
        case .education:
           eduProgressSelectedImage(progressBarView: progressBarView)
        case .expQuiz:
            expQuizProgressSelectedImage(progressBarView: progressBarView)
        case .exp:
            expProgressSelectedImage(progressBarView: progressBarView)
        case .skillQuiz:
            skillQuizProgressSelectedImage(progressBarView: progressBarView)
        case .skill:
            skillProgressSelectedImage(progressBarView: progressBarView)
        case .accomQuiz:
            accomQuizProgressSelectedImage(progressBarView: progressBarView)
        case .accom:
           accomProgressSelectedImage(progressBarView: progressBarView)
        }
    }
    
    func personalProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationActive
        progressBarView.educationButtonImage.image = UIImage.icEducationNoFill
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceNoFill
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillNoFill
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentInactive
    }
    
    func eduProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationFill
        progressBarView.educationButtonImage.image = UIImage.icEducationActive
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceNoFill
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillNoFill
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentInactive
    }
    
    func expQuizProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationFill
        progressBarView.educationButtonImage.image = UIImage.icEducationFill
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceActive
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillNoFill
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentInactive
    }
    
    func expProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationFill
        progressBarView.educationButtonImage.image = UIImage.icEducationFill
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceActive
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillNoFill
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentInactive
    }
    
    func skillQuizProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationFill
        progressBarView.educationButtonImage.image = UIImage.icEducationFill
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceFill
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillActive
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentInactive
    }
    
    func skillProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationFill
        progressBarView.educationButtonImage.image = UIImage.icEducationFill
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceFill
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillActive
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentInactive
    }
    
    func accomQuizProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationFill
        progressBarView.educationButtonImage.image = UIImage.icEducationFill
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceFill
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillFill
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentActive
    }
    
    func accomProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationFill
        progressBarView.educationButtonImage.image = UIImage.icEducationFill
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceFill
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillFill
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentActive
    }
}
