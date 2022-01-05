//
//  UPExperiecenFormVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPExperiecenFormVC: MVVMViewController<UPExperienceFormViewModel> {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundView: DesignableView!
    @IBOutlet weak var companyNameView: LabelWithTextField!
    @IBOutlet weak var jobTitleView: LabelWithTextField!
    @IBOutlet weak var jobStatusView: LabelWithSwitch!
    @IBOutlet weak var jobPeriodView: LabelWithStartEndDate!
    @IBOutlet weak var jobSummaryView: LabelWithTextView!
    @IBOutlet weak var addOrDeleteButton: UIButton!
    
    var expPh: String = ""
    var expSuggest = String()
    var experience: Experience?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UPExperienceFormViewModel()
        setup()
        getInitialData()
        // Do any additional setup after loading the view.
    }
}

//MARK: Initial Setup
extension UPExperiecenFormVC{
    func setup(){
        self.title = "Experience"
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

//MARK: Core Data
extension UPExperiecenFormVC{
    func getInitialData(){
        
    }
}
