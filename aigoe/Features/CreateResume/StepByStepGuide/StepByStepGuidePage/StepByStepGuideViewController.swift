//
//  StepByStepGuideViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class StepByStepGuideViewController: MVVMViewController<StepByStepGuideViewModel> {
    
    var index: Int?
    var selectedTemplate: Int?
    var selectedUserResume = User_Resume()
    var isCreate = Bool()
    var isGenerate = false
    var formSource = String()
    var eduData = [Education]()
    var expData = [Experience]()
    var skillData = [Skills]()
    var accomData = [Accomplishment]()
    
    @IBOutlet weak var progressBarView: ProgressBarView!
    @IBOutlet  var smallSetButtonView: SmallSetButton!
    @IBAction func unwind( _ seg: UIStoryboardSegue) {}
    
    @IBAction func unwindToStep(_ unwindSegue: UIStoryboardSegue) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = StepByStepGuideViewModel()
        smallSetButtonView.delegate = self
        progressBarView.dlgt = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageController = segue.destination as? StepByStepGuidePageController {
            pageController.stepSetup(stepDlgt: self)
            pageController.prevNextSetup(prevNextDlgt: self)
            pageController.selectedResume = selectedUserResume
            pageController.isCreate = isCreate
            pageController.eduData = eduData
            pageController.expData = expData
            pageController.skillData = skillData
            pageController.accomData = accomData
        } else if let vc = segue.destination as? ExperienceFormController {
            //vc.setup(dlgt: self)
            vc.isCreate = isCreate
        } else if let vc = segue.destination as? EducationFormController {
            //vc.setup(dlgt: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if formSource == "education" {
            NotificationCenter.default.post(name: Notification.Name("eduReload"), object: nil)
        } else if formSource == "experience" {
            NotificationCenter.default.post(name: Notification.Name("expReload"), object: nil)
        } else if formSource == "skill" {
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
    
    func changeTitleToGenerate(was: Bool) {
        smallSetButtonView.rightButton.setTitle("Generate", for: .normal)
        isGenerate = true
    }
    
    func isButtonEnable (left: Bool, right: Bool) {
        if !left {
            smallSetButtonView.leftButton.dsShortUnfilledButton(isDelete: false, isDisable: true, text: "Previous")
        } else {
            smallSetButtonView.leftButton.dsShortUnfilledButton(isDelete: false, isDisable: false, text: "Previous")
        }
        
        if !right {
            smallSetButtonView.rightButton.dsShortFilledPrimaryButton(isDisable: true, text: "Next")
        } else {
            smallSetButtonView.rightButton.dsShortFilledPrimaryButton(isDisable: false, text: "Next")
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
    
    func didTapPrevious() {
        NotificationCenter.default.post(name: Notification.Name("goToPrev"), object: nil)
    }
    
    func didTapGenerate() {
        performSegue(withIdentifier: "goToGenerate", sender: self)
    }
}

//MARK: Step Page Controller Delegate
extension StepByStepGuideViewController: StepByStepGuideDelegate {
    func goToAddEdu(was: Bool, from: String) {
        let storyboard = UIStoryboard(name: "EducationFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEduForm") as! EducationFormController
        vc.dataFrom = from
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToEditEdu(was: Bool, from: String, edu: Education) {
        let storyboard = UIStoryboard(name: "EducationFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEduForm") as! EducationFormController
        vc.dataFrom = from
        vc.eduData = edu
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToAddExp(was: Bool, from: String) {
        let storyboard = UIStoryboard(name: "ExperienceFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToExperienceForm") as! ExperienceFormController
        vc.isCreate = isCreate
        vc.dataFrom = from
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToEditExp(was: Bool, from: String, exp: Experience) {
        //performSegue(withIdentifier: "goToExperienceForm", sender: self)
        let storyboard = UIStoryboard(name: "ExperienceFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToExperienceForm") as! ExperienceFormController
        vc.isCreate = isCreate
        vc.dataFrom = from
        vc.experience = exp
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToGenerate(was: Bool) {
        if was {
            didTapGenerate()
        }
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

