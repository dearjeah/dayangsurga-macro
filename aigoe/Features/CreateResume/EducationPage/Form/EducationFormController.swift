//
//  EducationFormController.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 30/10/21.
//

import UIKit

protocol EduFormDelegate: AnyObject {
    func addDeleteEdu()
}

class EducationFormController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var institutionView: LabelWithTextField!
    @IBOutlet weak var qualificationView: LabelWithTextField!
    @IBOutlet weak var eduStatusView: LabelWithSwitch!
    @IBOutlet weak var eduPeriodView: LabelWithStartEndDate!
    @IBOutlet weak var gpaView: LabelWithTextField!
    @IBOutlet weak var activityView: LabelWithTextView!
    @IBOutlet weak var addOrDeleteButton: UIButton!
    
    weak var delegate: EduFormDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setupForm()
        hideKeyboardWhenTappedAround()
    }
    
    func setView(){
        self.title = "Education"
        self.navigationController?.navigationBar.prefersLargeTitles = false
//        scrollView.contentSize = CGSize(width: 400, height: 2300)
        addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Education")
    }
    
    func setupForm(){
        // for institution
        institutionView.titleLabel.text = "Institution*"
        institutionView.textField.placeholder = "e.g. Universitas Gadjah Mada"
        
        // for qualification
        qualificationView.titleLabel.text = "Qualification*"
        qualificationView.textField.placeholder = "e.g. Bachelor of Computer Science"
        
        // for edu status
        eduStatusView.titleLabel.text = "Education Status*"
        eduStatusView.switchTitle.text = "Currently Studying Here"
        
        //for period
        eduPeriodView.titleLabel.text = "Education Period*"
        
        // for gpa
        gpaView.titleLabel.text = "GPA*"
        gpaView.textField.placeholder = "e.g. 3.90"
        
        // for activity / project
        activityView.titleLabel.text = "Activity/Project"
        activityView.textView.placeholder = ""
        activityView.textView.text = "Lead a new CLOAD application project with a team of 5 people focusing on ATS-friendly resume."
        activityView.cueLabel.text = "To show experiences or skills you want to highlight, consider to include relevant projects or activities that align with the job qualifications."
    }
    
    @IBAction func addorDeleteAction(_ sender: Any) {
        tapToAddDeleteButton()
    }
    
    // protocol -- go to list edu
    func tapToAddDeleteButton(){
        delegate?.addDeleteEdu()
    }
}
