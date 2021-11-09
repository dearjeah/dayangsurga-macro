//
//  XIBTesViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 29/10/21.
//

import UIKit



class XIBTesViewController: MVVMViewController<StepByStepGuideViewModel>{

    @IBOutlet weak var experienceListView: ExperiencePageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        experienceListView.experienceDelegate = self

    }
}

extension XIBTesViewController: ExperienceListDelegate {
    func getSelectedIndex(index: Int) {

    }
    
    func goToAddExp() {
        let storyboard = UIStoryboard(name: "ExperienceFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToExperienceForm") as! ExperienceFormController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func passingExpData(exp: Experience?) {
//        let experience = Experience()
        let storyboard = UIStoryboard(name: "ExperienceFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToExperienceForm") as! ExperienceFormController

        vc.experience = exp
        vc.from = "edit"
        self.navigationController?.pushViewController(vc, animated: true)
            // present(controller, animated: true, completion: nil) // if presented from ViewController
        
        
//
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
