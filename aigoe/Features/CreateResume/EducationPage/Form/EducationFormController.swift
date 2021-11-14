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

class EducationFormController: MVVMViewController<EducationFormViewModel> {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var institutionView: LabelWithTextField!
    @IBOutlet weak var qualificationView: LabelWithTextField!
    @IBOutlet weak var eduStatusView: LabelWithSwitch!
    @IBOutlet weak var eduPeriodView: LabelWithStartEndDate!
    @IBOutlet weak var gpaView: LabelWithTextField!
    @IBOutlet weak var activityView: LabelWithTextView!
    @IBOutlet weak var addOrDeleteButton: UIButton!
    
    weak var delegate: EduFormDelegate?
    var eduData: Education? = nil
    var eduPlaceholder: Edu_Placeholder?
    var eduSuggestion: Edu_Suggestion?
    var placeholderLabel : UILabel!
    var switcherStatus: Bool!
    var getIndexExp = Int()
    var dataFrom = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = EducationFormViewModel()
        eduPlaceholder = self.viewModel?.getEduPh()
        eduSuggestion = self.viewModel?.getEduSuggest()
        
        setView()
        setupForm()
        hideKeyboardWhenTappedAround()
    }
    
    func setView(){
        self.title = "Education"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Education")
    }
    
    func setupForm(){
        // for institution
        institutionView.titleLabel.text = "Institution*"
        institutionView.textField.placeholder = eduPlaceholder?.institution_ph
        
        // for qualification
        qualificationView.titleLabel.text = "Qualification*"
        qualificationView.textField.placeholder = eduPlaceholder?.title_ph
        
        // for edu status
        eduStatusView.titleLabel.text = "Education Status*"
        eduStatusView.switchTitle.text = "Currently Studying Here"
        
        //for period
        eduPeriodView.titleLabel.text = "Education Period*"
        
        // for gpa
        gpaView.titleLabel.text = "GPA*"
        gpaView.textField.placeholder = eduPlaceholder?.gpa_ph
        
        // for activity / project
        activityView.titleLabel.text = "Activity/Project"
        activityView.textView.placeholder = ""
        activityView.textView.text = eduPlaceholder?.activity_ph
        activityView.cueLabel.text = eduSuggestion?.activity_suggest
    }
    
    @IBAction func addorDeleteAction(_ sender: Any) {
        tapToAddDeleteButton()
    }
    
    // protocol -- go to list edu
    func tapToAddDeleteButton(){
        delegate?.addDeleteEdu()
    }
}

extension EducationFormController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView){
       
        if ( activityView.textView.text.count  + 1 == eduPlaceholder?.activity_ph?.count){
                activityView.textView.text = ""
            }
        activityView.textView.textColor = .black
    }
}
