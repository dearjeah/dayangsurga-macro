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
    
    func setup(dlgt: EduFormDelegate) {
        self.delegate = dlgt
    }
    
    @IBAction func addorDeleteAction(_ sender: Any) {
        tapToAddDeleteButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = EducationFormViewModel()
        eduPlaceholder = self.viewModel?.getEduPh()
        eduSuggestion = self.viewModel?.getEduSuggest()
        
        setView()
        setupForm()
        hideKeyboardWhenTappedAround()
        self.activityView.textView.delegate = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? StepByStepGuideViewController {
            vc.formSource = "education"
        }
    }
    
    func tapToAddDeleteButton(){
        if !alertForCheckTF() {
            if dataFrom == "add" {
                guard let data = self.viewModel?.addEdu(
                    institution: institutionView.textField.text ?? "",
                    title: qualificationView.textField.text ?? "",
                    startDate: eduPeriodView.startDatePicker.date,
                    endDate: eduPeriodView.endDatePicker.date,
                    gpa: gpaView.textField.text ?? "",
                    activity: activityView.textView.text ?? "",
                    currentlyStudy: eduStatusView.switchButton.isOn,
                    isSelected: true
                ) else { return errorSaveData(from: "Save") }
                
                if data {
                    performSegue(withIdentifier: "backToStepVC", sender: self)
                } else {
                    errorSaveData(from: "Save")
                }
            } else {
               showAlertForDelete()
            }
        }
    }
    
    @objc func updateEdu(sender: UIBarButtonItem) {
        if !alertForCheckTF() {
            guard let eduID = eduData?.edu_id else { return }
            guard let data = self.viewModel?.updateEdu(eduId: eduID,
                institution: institutionView.textField.text ?? "",
                title: qualificationView.textField.text ?? "",
                startDate: eduPeriodView.startDatePicker.date,
                endDate: eduPeriodView.endDatePicker.date,
                gpa: gpaView.textField.text ?? "",
                activity: activityView.textView.text ?? "",
                currentlyStudy: eduStatusView.switchButton.isOn,
                isSelected: true
            ) else { return errorSaveData(from: "Update") }
            
            if data {
                performSegue(withIdentifier: "backToStepVC", sender: self)
            } else {
                errorSaveData(from: "Update")
            }
        }
    }
    
    func deleteEduData(){
        guard let data = self.viewModel?.deleteEduData(eduData: eduData ?? Education()) else { return }
        if data {
            performSegue(withIdentifier: "backToStepVC", sender: self)
        } else {
            errorSaveData(from: "Delete")
        }
    }
}

//MARK: Delegate
extension EducationFormController: LabelSwitchDelegate {
    func getValueSwitch() {
        if (eduStatusView.switchButton.isOn){
            eduPeriodView.endDatePicker.isEnabled = false
        } else {
            eduPeriodView.endDatePicker.isEnabled = true
        }
    }
}

//MARK: Alert
extension EducationFormController {
    func alertForCheckTF() -> Bool {
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
            return true
        }
        return false
    }
    
    func showAlertForDelete(){
        let alert = UIAlertController(title: "Delete Data?", message: "You will not be able to recover it.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in self.deleteEduData()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorSaveData(from: String){
        let alert = UIAlertController(title: "Unable to \(from) Data", message: "Your data is not saved. Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension EducationFormController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView){
        eduPlaceholder = self.viewModel?.getEduPh()
        if ( activityView.textView.text.lowercased()  == eduPlaceholder?.activity_ph?.lowercased() ){
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
        self.navigationController?.navigationItem.leftBarButtonItem?.title = ""
        if dataFrom == "add" {
            addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Education")
        } else {
            addOrDeleteButton.dsLongUnfilledButton(isDelete: true, text: "Delete Education")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateEdu(sender:)))
        }
    }
    
    func setupForm(){
        institutionView.titleLabel.text = "Institution*"
        qualificationView.titleLabel.text = "Qualification*"
        eduStatusView.titleLabel.text = "Education Status*"
        eduStatusView.switchTitle.text = "Currently Studying Here"
        eduPeriodView.titleLabel.text = "Education Period*"
        gpaView.titleLabel.text = "GPA*"
        activityView.titleLabel.text = "Activity/Project"
        activityView.textView.delegate = self
        activityView.textView.textColor = .lightGray
        activityView.cueLabel.text = eduSuggestion?.activity_suggest
        
        institutionView.textField.placeholder = eduPlaceholder?.institution_ph
        qualificationView.textField.placeholder = eduPlaceholder?.title_ph
        gpaView.textField.placeholder = eduPlaceholder?.gpa_ph
        activityView.textView.placeholder = eduPlaceholder?.activity_ph
        activityView.textView.text = eduPlaceholder?.activity_ph
       
       
        
        if dataFrom == "edit" {
            if eduData != nil {
                let gpa = String(describing: eduData?.gpa)
                institutionView.textField.text = eduData?.institution
                qualificationView.textField.text = eduData?.title
                gpaView.textField.text = gpa
                activityView.textView.text = eduData?.activity
                
                eduStatusView.switchButton.isOn = ((eduData?.currently_study) == true)
                eduPeriodView.startDatePicker.date = eduData?.start_date ?? Date()
                eduPeriodView.endDatePicker.date = eduData?.end_date ?? Date()
                if eduData?.activity != "" {
                    activityView.textView.textColor = .black
                }
            }
        } else {
            activityView.textView.textColor = .lightGray
        }
    }
}
