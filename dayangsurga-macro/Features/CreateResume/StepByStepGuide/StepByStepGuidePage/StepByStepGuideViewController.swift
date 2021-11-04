//
//  StepByStepGuideViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol StepVCdelegate: AnyObject {
    func didSelectNext()
    func didSelectPrev()
    func didSelectGenerate()
}

class StepByStepGuideViewController: MVVMViewController<StepByStepGuideViewModel> {
    
    var index: Int?
    var selectedData = User_Resume()
    var selectedIndex: Int?


    @IBOutlet weak var progressBarView: ProgressBarView!
    @IBOutlet weak var smallSetButtonView: SmallSetButton!
    
    weak var delegate: StepVCdelegate?
    
    func setup(dlgt: StepVCdelegate) {
        self.delegate = dlgt
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smallSetButtonView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageController = segue.destination as? StepByStepGuidePageController {
            pageController.stepSetup(stepDlgt: self)
        }
    }*/

}

extension StepByStepGuideViewController: prevNextButtonDelegate, SmallSetButtonDelegate/*, StepByStepGuideDelegate*/ {
    //MARK: Delegate Function
    func didTapNext() {
        delegate?.didSelectNext()
    }
    
    func didTapPrevious() {
        delegate?.didSelectPrev()
    }
    
    func didTapGenerate() {
        delegate?.didSelectGenerate()
    }
    
    
    
    /*func progressBarUpdate(index: Int) {
        <#code#>
    }*/
    
    /*func didSelectNext() {
        <#code#>
    }
    
    func didSelectPrev() {
        <#code#>
    }
    
    func didSelectGenerate() {
        <#code#>
    }*/
    
    func isHidePrevNextButton(was: Bool) {
        if was {
            smallSetButtonView.isHidden = true
        } else {
            smallSetButtonView.isHidden = false
        }
    }
}

