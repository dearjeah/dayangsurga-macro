//
//  ExperienceFormController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 28/10/21.
//

import UIKit

protocol ExperiencePageDelegate {
    func addExperience()
}

class ExperienceFormController: UIViewController {
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var companyName: LabelWithTextField!
    @IBOutlet weak var jobTitle: LabelWithTextField!
    @IBOutlet weak var jobStatus: LabelWithSwitch!
    @IBOutlet weak var jobPeriod: LabelWithStartEndDate!
    @IBOutlet weak var jobSummary: LabelWithTextView!
    @IBOutlet weak var addExpBtn: UIButton!
    
    var expDelegate: ExperiencePageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    @IBAction func addExperiencePressed(_ sender: UIButton) {
        expDelegate?.addExperience()
        //add/update to core data
    }
    
    func setup(){
        companyName.titleLabel.text = "Company Name*"
        jobTitle.titleLabel.text = "Job Title*"
        jobStatus.titleLabel.text = "Job Status*"
        jobStatus.switchTitle.text = "Currently Working Here"
        jobPeriod.titleLabel.text = "Job Period*"
        jobSummary.titleLabel.text = "Job Summary*"
        jobSummary.cueLabel.text = "Describe what you have done before that matches with the job qualifications, make sure you use action verbs."
        addExpBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add Experience")
        
    }
    
    
    

}
