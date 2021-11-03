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

        // Do any additional setup after loading the view.
    }

}

