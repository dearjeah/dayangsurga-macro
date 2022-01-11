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
    let personalInfoRepo = PersonalInfoRepository.shared
    let experienceRepo = ExperienceRepository.shared
    let eduRepo = EducationRepository.shared
    let skillRepo = SkillRepository.shared
    let accomRepo = AccomplishmentRepository.shared
    let resumeContentRepo = ResumeContentRepository.shared
    let userResumeRepo = UserResumeRepository.shared

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
    
    func getResumeContentId(resumeId: String) -> String {
        let resumeContent = resumeContentRepo.getResumeContentById(resume_id: resumeId)
        let resumeContentId = resumeContent?.resume_id ?? ""
        
        return resumeContentId
    }
    
    
    func updatePersonalInfo(data: PersonalInfo, userId: String) {
        personalInfoRepo.updatePersonalInfo(id: data.id,
                                            newName: data.name ,
                                            newPhoneNumber: data.phoneNumber ,
                                            newEmail: data.email ,
                                            newLocation: data.location ,
                                            newSummary: data.summary 
        )
    }
    
    func updateSelectedEduToResume(resumeId: String, eduId: String) {
        resumeContentRepo.updateResumeContentEdu(resume_id: resumeId, newEdu_id: eduId)
    }
    
    func updateSelectedExpToResume(resumeId: String, expId: String) {
        resumeContentRepo.updateResumeContentExp(resume_id: resumeId, newExp_id: expId)
    }
    
    func updateSelectedSkillsToResume(resumeId: String, skillId: String) {
        resumeContentRepo.updateResumeContentSkill(resume_id: resumeId, newSkill_id: skillId)
    }
    
    func updateSelectedAccompToResume(resumeId: String, accompId: String) {
        resumeContentRepo.updateResumeContentAccomp(resume_id: resumeId, newAccomp_id: accompId)
    }
    
    func updateUserResumePDFThumbnail(resumeId: String, img: UIImage) {
        userResumeRepo.updateResumeThumbnail(resume_id: resumeId, resumeThumbnail: img)
    }
}

//MARK: Update Checklist on Table View

extension StepByStepGuideViewModel {
    func updateEduSelection(resumeContentId: String, id: String, isSelected: Bool) {
        eduRepo.updateSelectedEduStatus(edu_id: id, isSelected: isSelected)
        if isSelected {
            updateSelectedEduToResume(resumeId: resumeContentId, eduId: id)
        } else {
            resumeContentRepo.deleteResumeContentEdu(resume_id: id, eduId: id)
        }
    }
    
    func updateExpSelection(resumeContentId: String, id: String, isSelected: Bool) {
        experienceRepo.updateSelectedExpStatus(exp_id: id, isSelected: isSelected)
        if isSelected {
           updateSelectedExpToResume(resumeId: resumeContentId, expId: id)
        } else {
            resumeContentRepo.deleteResumeContentExp(resume_id: id, expId: id)
        }
    }
    
    func updateSkillSelection(resumeContentId: String, id: String, isSelected: Bool) {
        skillRepo.updateSelectedSkillStatus(skill_id: id, isSelected: isSelected)
        if isSelected {
           updateSelectedSkillsToResume(resumeId: resumeContentId, skillId: id)
        } else {
            resumeContentRepo.deleteResumeContentSkill(resume_id: resumeContentId, skillId: id)
        }
    }
    
    func updateAccomSelection(resumeContentId: String, id: String, isSelected: Bool) {
        accomRepo.updateSelectedAccomplishStatus(accomId: id, is_Selected: isSelected)
        if isSelected {
           updateSelectedAccompToResume(resumeId: resumeContentId, accompId: id)
        } else {
            resumeContentRepo.deleteResumeContentAccomp(resume_id: resumeContentId, accompId: id)
        }
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
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationUnfilled
        progressBarView.educationButtonImage.image = UIImage.icEducationActive
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceNoFill
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillNoFill
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentInactive
    }
    
    func expQuizProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationUnfilled
        progressBarView.educationButtonImage.image = UIImage.icEducationUnfilled
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceActive
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillNoFill
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentInactive
    }
    
    func expProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationUnfilled
        progressBarView.educationButtonImage.image = UIImage.icEducationUnfilled
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceActive
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillNoFill
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentInactive
    }
    
    func skillQuizProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationUnfilled
        progressBarView.educationButtonImage.image = UIImage.icEducationUnfilled
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceUnfilled
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillActive
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentInactive
    }
    
    func skillProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationUnfilled
        progressBarView.educationButtonImage.image = UIImage.icEducationUnfilled
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceUnfilled
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillActive
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentInactive
    }
    
    func accomQuizProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationUnfilled
        progressBarView.educationButtonImage.image = UIImage.icEducationUnfilled
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceUnfilled
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillUnfilled
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentActive
    }
    
    func accomProgressSelectedImage(progressBarView: ProgressBarView){
        progressBarView.personalInformationButtonImage.image = UIImage.icPersonalInformationUnfilled
        progressBarView.educationButtonImage.image = UIImage.icEducationUnfilled
        progressBarView.workExperienceButtonImage.image = UIImage.icExperienceUnfilled
        progressBarView.technicalSkillButtonImage.image = UIImage.icTechnicalSkillUnfilled
        progressBarView.accomplishmentButtonImage.image = UIImage.icAccomplishmentActive
    }
}
