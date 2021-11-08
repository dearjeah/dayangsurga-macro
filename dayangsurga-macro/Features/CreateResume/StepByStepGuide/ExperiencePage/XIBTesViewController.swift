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

//        experienceListView.experienceDelegate = self
    }


}
