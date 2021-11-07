//
//  StepByStepGuideViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class StepByStepGuideViewController: MVVMViewController<StepByStepGuideViewModel> {
    
    var index: Int?
    var selectedData = User_Resume()
    var selectedIndex: Int?


    @IBOutlet weak var progressBarView: ProgressBarView!
    @IBOutlet weak var smallSetButtonView: SmallSetButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smallSetButtonView.delegate = self
        progressBarView.dlgt = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageController = segue.destination as? StepByStepGuidePageController {
            pageController.stepSetup(stepDlgt: self)
            pageController.prevNextSetup(prevNextDlgt: self)
            
        }
    }
}

extension StepByStepGuideViewController: prevNextButtonDelegate, SmallSetButtonDelegate, StepByStepGuideDelegate, ProgressBarDelegate {
   
    
    func goToGenerate(was: Bool) {
        performSegue(withIdentifier: "goToGenerate", sender: self)
    }
    
    func progressBarUpdate(index: Int) {
        
    }

    //MARK: Delegate Function
    func didTapNext() {
        NotificationCenter.default.post(name: Notification.Name("goToNext"), object: nil)
    }
    
    func didTapPrevious() {
        NotificationCenter.default.post(name: Notification.Name("goToPrev"), object: nil)
    }
    
    func didTapGenerate() {
        //NotificationCenter.default.post(name: Notification.Name("goToGenerate"), object: nil)
        performSegue(withIdentifier: "goToGenerate", sender: self)
    }
    
    //prevNextButtonDelegate
    func isHidePrevNextButton(was: Bool) {
        if was {
            smallSetButtonView.isHidden = true
        } else {
            smallSetButtonView.isHidden = false
        }
    }
    
    func changeTitleToGenerate(was: Bool) {
        smallSetButtonView.rightButton.titleLabel?.text = "Generate"
    }
    
    //MARK: Progress Bar Delegate
    func progressBarSelected(at: Int) {
        let page = ["Page": at]
        NotificationCenter.default.post(name: Notification.Name("progressBarTapped"), object: self, userInfo: page)
    }
}

