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
    
    @IBAction func addorDeleteAction(_ sender: Any) {
        tapToAddDeleteButton()
    }
    
    // protocol -- go to list edu
    func tapToAddDeleteButton(){
        delegate?.addDeleteEdu()
    }
    
    func deleteEduData(){
        self.viewModel?.deleteEduData(eduData: eduData ?? Education())
        self.navigationController?.popViewController(animated: false)
    }
}

//MARK: Alert
extension EducationFormController {
    func alertForCheckTF(){
        if ((institutionView.textField.text?.isEmpty) != false) ||
            ((qualificationView.textField.text?.isEmpty) != false) ||
            ((gpaView.textField.text?.isEmpty) != false ||
             (activityView.textView.text.isEmpty) != false )
        {
            let alert = UIAlertController(
                title: "Field Can't Be Empty",
                message: "You must fill in every mandatory fields in this form.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertForDelete(){
        let alert = UIAlertController(title: "Delete Data?", message: "You will not be able to recover it.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in self.deleteEduData()}))
        self.present(alert, animated: true, completion: nil)
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

//MARK: Initial Setup
extension EducationFormController {
    func setView(){
        self.title = "Education"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        if dataFrom == "add" {
            addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Education")
        } else {
            addOrDeleteButton.dsLongUnfilledButton(isDelete: true, text: "Delete Education")
        }
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
}
