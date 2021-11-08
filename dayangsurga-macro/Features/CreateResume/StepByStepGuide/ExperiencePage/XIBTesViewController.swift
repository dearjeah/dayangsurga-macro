//
//  XIBTesViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 29/10/21.
//

import UIKit

class XIBTesViewController: MVVMViewController<StepByStepGuideViewModel>, ExperienceListDelegate {

    @IBOutlet weak var experienceListView: ExperiencePageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        experienceListView.experienceDelegate = self
    }
    
    func goToExpereinceController() {
        let storyboard = UIStoryboard(name: "ExperienceFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToExperienceForm") as! ExperienceFormController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func goToEdit() {
//        let storyboard = UIStoryboard(name: "ExperienceFormController", bundle: nil)
//        let vc = storyboard.instantiateViewController(identifier: "goToExperienceForm") as! ExperienceFormController
//        self.navigationController?.pushViewController(vc, animated: true)
//    }

}
