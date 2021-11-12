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
    
    override func viewWillAppear(_ animated: Bool) {
        experienceListView.getAndReload()
    }
    //    @IBAction func unwindToXIB(_ unwindSegue: UIStoryboardSegue) {
    //        let sourceViewController = unwindSegue.source
            // Use data from the view controller which initiated the unwind segue
    //    }
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
        let storyboard = UIStoryboard(name: "ExperienceFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToExperienceForm") as! ExperienceFormController
        vc.experience = exp
        vc.dataFrom = "edit"
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
