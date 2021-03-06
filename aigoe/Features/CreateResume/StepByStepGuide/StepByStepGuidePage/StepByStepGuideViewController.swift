//
//  StepByStepGuideViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit
import CloudKit

class StepByStepGuideViewController: MVVMViewController<StepByStepGuideViewModel> {
    
    var index: Int = 0
    var selectedTemplate: Int = 0
    var selectedUserResume = User_Resume()
    var selectedResumeContent = Resume_Content()
    var isCreate = Bool()
    var isGenerate = false
    var formSource = String()
    var eduData = [Education]()
    var expData = [Experience]()
    var skillData = [Skills]()
    var accomData = [Accomplishment]()
    var selectedResumeContentId = String()
    var currentUserId = ""
    
    @IBOutlet weak var progressBarView: ProgressBarView!
    @IBOutlet  var smallSetButtonView: SmallSetButton!
    @IBAction func unwind( _ seg: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = StepByStepGuideViewModel()
        self.navigationItem.title = "New Resume"
        self.navigationItem.backButtonTitle = "Template"
        smallSetButtonView.delegate = self
        progressBarView.dlgt = self
        hideKeyboardWhenTappedAround()
        smallSetButtonView.buttonStyle(from: "step")
        
        if !isCreate {
            selectedResumeContentId = self.viewModel?.getResumeContentId(resumeId: selectedUserResume.resume_id ?? "") ?? ""
            currentUserId = self.viewModel?.getCurrentUserId() ?? ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageController = segue.destination as? StepByStepGuidePageController {
            pageController.stepSetup(stepDlgt: self)
            pageController.prevNextSetup(prevNextDlgt: self)
            pageController.selectedResume = selectedUserResume
            pageController.isCreate = isCreate
            pageController.currentResumeContent = selectedResumeContent
            pageController.currentUserId = currentUserId
        } else if let vc = segue.destination as? GenerateResumeController {
            vc.selectedTemplate = selectedTemplate
            vc.userResume = selectedUserResume
            vc.resumeContentId = selectedResumeContentId
            vc.userResumeContent = selectedResumeContent
            vc.currentUserId = currentUserId
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if formSource == "personalInfo" {
            NotificationCenter.default.post(name: Notification.Name("personalInfoReload"), object: nil)
        } else if formSource == "education" {
            NotificationCenter.default.post(name: Notification.Name("eduReload"), object: nil)
        } else if formSource == "experience" {
            NotificationCenter.default.post(name: Notification.Name("expReload"), object: nil)
        } else if formSource == "skills" {
            NotificationCenter.default.post(name: Notification.Name("skillReload"), object: nil)
        } else if formSource == "accomplishment" {
            NotificationCenter.default.post(name: Notification.Name("accompReload"), object: nil)
        } else {
            return
        }
    }
}

//MARK: Delegate Function
extension StepByStepGuideViewController: prevNextButtonDelegate {
    func isHidePrevNextButton(was: Bool) {
        if was {
            smallSetButtonView.isHidden = true
        } else {
            smallSetButtonView.isHidden = false
        }
    }
    
    func changeTitleToGenerate(was: Bool, isEnable: Bool) {
        smallSetButtonView.rightButton.dsLongFilledPrimaryButton(withImage: false, text: "Preview", isEnable: isEnable)
        isGenerate = true
    }
    
    func isButtonEnable (left: Bool, right: Bool) {
        if !left {
            smallSetButtonView.leftButton.dsShortUnfilledButton(isDelete: false, isDisable: true, text: "Previous")
        } else {
            smallSetButtonView.leftButton.dsShortUnfilledButton(isDelete: false, isDisable: false, text: "Previous")
        }
        
        if !right {
            smallSetButtonView.rightButton.dsShortUnfilledButton(isDelete: false, isDisable: true, text: "Next")
        } else {
            smallSetButtonView.rightButton.dsShortUnfilledButton(isDelete: false, isDisable: false, text: "Next")
        }
        smallSetButtonView.leftButton.isEnabled = left
        smallSetButtonView.rightButton.isEnabled = right
    }
}

//MARK: SmallSetButtonDelegate
extension StepByStepGuideViewController: SmallSetButtonDelegate {
    func didTapRightButton() {
        if smallSetButtonView.rightButton.titleLabel?.text == "Next" {
            didTapNext()
        } else {
            didTapGenerate()
        }
    }
    func didTapNext() {
        NotificationCenter.default.post(name: Notification.Name("goToNext"), object: nil)
    }
    
    func didTapLeftButton() {
        NotificationCenter.default.post(name: Notification.Name("goToPrev"), object: nil)
    }
    
    func didTapGenerate() {
        if let resumeContent = ResumeContentRepository.shared.getResumeContentById(resume_id: selectedResumeContentId) {
            createPDFThumbnail(resumeContent: resumeContent)
            performSegue(withIdentifier: "goToGenerate", sender: self)
        } else {
            print("Step VC =========== Cannot get user resume content ID")
        }
         
    }
    
    func createPDFThumbnail(resumeContent: Resume_Content){
        let pdfCreator = PDFCreator(resumeContent: resumeContent, userResume: selectedUserResume, selectedTemplate: selectedTemplate)
        let pdfData = pdfCreator.createPDF()
        let thumbnailSize = CGSize(width: 260, height: 463)
        let thumbnail = pdfCreator.generatePdfThumbnail(of: thumbnailSize, atPage: 0, pdfData: pdfData)
        self.viewModel?.updateUserResumePDFThumbnail(resumeId: resumeContent.resume_id ?? "", img: thumbnail ?? UIImage())
    }
    
    func dataChecker(page: Int, edu: [Education], exp: [Experience], skill: [Skills], accomp: [Accomplishment]) {
        let resumeId = selectedUserResume.resume_id ?? ""
        let eduId = edu[0].edu_id ?? ""
        let expId = exp[0].exp_id ?? ""
        let skillId = skill[0].skill_id ?? ""
        let accompId = accomp[0].accomplishment_id ?? ""
        
        switch page {
        case 1:
            self.viewModel?.updateSelectedEduToResume(resumeId: resumeId, eduId: eduId)
        case 2:
            self.viewModel?.updateSelectedExpToResume(resumeId: resumeId, expId: expId)
        case 3:
            self.viewModel?.updateSelectedSkillsToResume(resumeId: resumeId, skillId: skillId)
        case 4:
            self.viewModel?.updateSelectedAccompToResume(resumeId: resumeId, accompId: accompId)
        default:
            print("not detected")
        }
    }
}

//MARK: Step Page Controller Delegate
extension StepByStepGuideViewController: StepByStepGuideDelegate {
    func updateTableChecklist(from: String, id: String, isSelected: Bool) {
        if from == "edu" {
            self.viewModel?.updateEduSelection(resumeContentId: selectedResumeContentId, id: id, isSelected: isSelected)
        } else if from == "exp" {
            self.viewModel?.updateExpSelection(resumeContentId: selectedResumeContentId, id: id, isSelected: isSelected)
        } else if from == "skill" {
            self.viewModel?.updateSkillSelection(resumeContentId: selectedResumeContentId, id: id, isSelected: isSelected)
        } else if from == "accomp" {
            self.viewModel?.updateAccomSelection(resumeContentId: selectedResumeContentId, id: id, isSelected: isSelected)
        } else if from == "personal" {
            self.viewModel?.updatePersonalInfoSelection(resumeContentId: selectedResumeContentId, id: id, isSelected: isSelected)
        } else {
            print("Step View Controller =======checklist is from unknown directory========")
        }
        
    }
    
    func updateData(page: Int) {
        let data = self.viewModel?.getAllInitialData()
        eduData = data?.edu ?? []
        expData = data?.exp ?? []
        skillData = data?.skill ?? []
        accomData =  data?.accom ?? []
        //dataChecker(page: page, edu:edu, exp: exp, skill: skills, accomp: accomp)
    }
    
    func personalInfoUpdate(data: PersonalInfo) {
        self.viewModel?.updatePersonalInfo(data: data, userId: currentUserId)
    }
    
    func goToAddEdu(was: Bool, from: String) {
        let storyboard = UIStoryboard(name: "EducationFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEduForm") as! EducationFormController
        vc.dataFrom = from
        vc.currentUserId = currentUserId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToEditEdu(was: Bool, from: String, edu: Education) {
        let storyboard = UIStoryboard(name: "EducationFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEduForm") as! EducationFormController
        vc.dataFrom = from
        vc.eduData = edu
        vc.currentUserId = currentUserId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToAddExp(was: Bool, from: String) {
        let storyboard = UIStoryboard(name: "ExperienceFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToExperienceForm") as! ExperienceFormController
        vc.isCreate = isCreate
        vc.dataFrom = from
        vc.currentUserId = currentUserId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToEditExp(was: Bool, from: String, exp: Experience) {
        let storyboard = UIStoryboard(name: "ExperienceFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToExperienceForm") as! ExperienceFormController
        vc.isCreate = isCreate
        vc.dataFrom = from
        vc.experience = exp
        vc.currentUserId = currentUserId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToAddSkill(from: String) {
        let storyboard = UIStoryboard(name: "SkillAddEditController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEditSkills") as! SkillAddEditController
        vc.currentUserId = currentUserId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToEditSkill(from: String, skills: [Skills]) {
        let storyboard = UIStoryboard(name: "SkillAddEditController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEditSkills") as! SkillAddEditController
        vc.skill = skills
        vc.dataFrom = from
        vc.currentUserId = currentUserId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToAddAccom(was: Bool, from: String) {
        let storyboard = UIStoryboard(name: "AccomplishFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToAccomForm") as! AccomplishFormController
        vc.dataFrom = from
        vc.currentUserId = currentUserId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToEditAccom(was: Bool, from: String, accomp: Accomplishment) {
        let storyboard = UIStoryboard(name: "AccomplishFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToAccomForm") as! AccomplishFormController
        vc.dataFrom = from
        vc.accomplish = accomp
        vc.currentUserId = currentUserId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToGenerate(was: Bool) {
        if was {
            didTapGenerate()
        }
    }
    
    func goToPersonalInfoForm(from: String, personalInfo: Personal_Info) {
        let storyboard = UIStoryboard(name: "PersonalInfoForm", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToPersonalInfoForm") as! PersonalInfoFormVC
        vc.dataFrom = from
        vc.personalInfoData = personalInfo
        vc.currentUserId = currentUserId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Progress Bar Delegate
extension StepByStepGuideViewController: ProgressBarDelegate {
    func progressBarSelected(at: Int) {
        let page = ["Page": at]
        NotificationCenter.default.post(name: Notification.Name("progressBarTapped"), object: self, userInfo: page)
    }
    
    func progressBarUpdate(index: Int, totalData: Int) {
        if totalData == 5 {
            //from edit
            switch index {
            case 0:
                self.viewModel?.updateImage(progress: .personal, progressBarView: progressBarView)
            case 1:
                self.viewModel?.updateImage(progress: .education, progressBarView: progressBarView)
            case 2:
                self.viewModel?.updateImage(progress: .exp, progressBarView: progressBarView)
            case 3:
                self.viewModel?.updateImage(progress: .skill, progressBarView: progressBarView)
            case 4:
                self.viewModel?.updateImage(progress: .accom, progressBarView: progressBarView)
            default:
                print("not detected")
            }
        } else {
            //from create resume
            switch index {
            case 0:
                self.viewModel?.updateImage(progress: .personal, progressBarView: progressBarView)
            case 1:
                self.viewModel?.updateImage(progress: .education, progressBarView: progressBarView)
            case 2:
                self.viewModel?.updateImage(progress: .expQuiz, progressBarView: progressBarView)
            case 3:
                self.viewModel?.updateImage(progress: .exp, progressBarView: progressBarView)
            case 4:
                self.viewModel?.updateImage(progress: .skillQuiz, progressBarView: progressBarView)
            case 5:
                self.viewModel?.updateImage(progress: .skill, progressBarView: progressBarView)
            case 6:
                self.viewModel?.updateImage(progress: .accomQuiz, progressBarView: progressBarView)
            case 7:
                self.viewModel?.updateImage(progress: .accom, progressBarView: progressBarView)
            default:
                print("not detected")
            }
        }
    }
}

