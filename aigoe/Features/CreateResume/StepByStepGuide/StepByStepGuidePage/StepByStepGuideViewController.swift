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
    
    @IBOutlet weak var progressBarView: ProgressBarView!
    @IBOutlet  var smallSetButtonView: SmallSetButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = StepByStepGuideViewModel()
        smallSetButtonView.delegate = self
        progressBarView.dlgt = self
        //        navigationStyle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageController = segue.destination as? StepByStepGuidePageController {
            pageController.stepSetup(stepDlgt: self)
            pageController.prevNextSetup(prevNextDlgt: self)
            pageController.selectedResume = selectedUserResume
            pageController.isCreate = isCreate
        }
    }
    
    func navigationStyle(){
        configureNavigationBar(largeTitleColor: .white, backgoundColor:UIColor.primaryBlue, tintColor: UIColor.primaryBlue, title: "Create Resume", preferredLargeTitle: false, hideBackButton: false)
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

extension StepByStepGuideViewController: StepByStepGuideDelegate, ExperienceListDelegate {
    func goToGenerate(was: Bool) {
        if was {
            didTapGenerate()
        }
    }
    
    //MARK: Delegate For Experience List to Form
    func getSelectedIndex(index: Int) {
        //
    }
    func goToAddExp() {
        let storyboard = UIStoryboard(name: "ExperienceFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToExperienceForm") as! ExperienceFormController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func passingExpData(exp: Experience?) {
        //        let experience = Experience()
        performSegue(withIdentifier: "", sender: self)
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

