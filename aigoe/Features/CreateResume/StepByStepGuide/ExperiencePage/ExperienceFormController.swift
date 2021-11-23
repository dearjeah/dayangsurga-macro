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

class ExperienceFormController: MVVMViewController<ExperienceFormViewModel> {
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var companyName: LabelWithTextField!
    @IBOutlet weak var jobTitle: LabelWithTextField!
    @IBOutlet weak var jobStatus: LabelWithSwitch!
    @IBOutlet weak var jobPeriod: LabelWithStartEndDate!
    @IBOutlet weak var jobSummary: LabelWithTextView!
    @IBOutlet weak var addExpBtn: UIButton!
    
    var expDelegate: ExperiencePageDelegate?
    var experience: Experience? = nil
    var expPlaceholder: Experience_Placeholder?
    var expSuggestion: Experience_Suggestion?
    var placeholderLabel : UILabel!
    var switcherStatus: Bool!
    var getIndexExp = Int()
    var isCreate = Bool()
    var dataFrom = String()
    
    func setup(dlgt: ExperiencePageDelegate) {
        self.expDelegate = dlgt
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ExperienceFormViewModel()
        setup()
        expPlaceholder = self.viewModel?.getExpPh()
        expSuggestion = self.viewModel?.getExpSuggestion()
        hideKeyboardWhenTappedAround()
        self.jobSummary.textView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? StepByStepGuideViewController {
            vc.formSource = "experience"
        }
    }
    
    @IBAction func addExperiencePressed(_ sender: UIButton) {
        if !alertForCheckTF() {
            if experience == nil{
                //add
                guard let addExp = self.viewModel?.addExpData(title: jobTitle.textField.text ?? "",
                                                              jobDesc: jobSummary.textView.text ?? "",
                                                              company: companyName.textField.text ?? "",
                                                              startDate: jobPeriod.startDatePicker.date,
                                                              endDate: jobPeriod.endDatePicker.date,
                                                              status: jobStatus.switchButton.isOn,
                                                              isSelected: true) else { return errorSaveData() }
                
                if addExp {
                    performSegue(withIdentifier: "backToStepVC", sender: self)
                } else {
                    errorSaveData()
                }
                
            } else {
                //delete
                showAlertForDelete()
            }
        }
    }
    
    @objc func updateExp(sender: UIBarButtonItem) {
        if !alertForCheckTF() {
            guard let data = self.viewModel?.updateExpData(title: jobTitle.textField.text ?? "",
                                                           jobDesc: jobSummary.textView.text,
                                                           company: companyName.textField.text ?? "",
                                                           startDate: jobPeriod.startDatePicker.date,
                                                           endDate: jobPeriod.endDatePicker.date,
                                                           status: jobStatus.switchButton.isOn,
                                                           isSelected: true
            ) else { return errorSaveData() }
            
            if data {
                performSegue(withIdentifier: "backToStepVC", sender: self)
            } else {
                errorSaveData()
            }
        }
    }
    
    // for delete and reload
    func deleteExpData(){
        guard let data = self.viewModel?.deleteExpData(dataExperience: experience) else { return errorSaveData() }
        if data {
            performSegue(withIdentifier: "backToStepVC", sender: self)
        } else {
            errorSaveData()
        }
    }
}

//MARK: Alert
extension ExperienceFormController {
    func alertForCheckTF() -> Bool {
        if ((companyName.textField.text?.isEmpty) != false) || ((jobTitle.textField.text?.isEmpty) != false) || ((jobSummary.textView.text?.isEmpty) != false){
            let alert = UIAlertController(title: "Field Can't Be Empty", message: "You must fill in every mandatory fields in this form.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return true
        } else {
            return false
        }
    }
    
    func showAlertForDelete(){
        let alert = UIAlertController(title: "Delete Data?", message: "You will not be able to recover it.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in self.deleteExpData()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorSaveData(){
        let alert = UIAlertController(title: "Unable to Save Data", message: "Your data is not saved. Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: Delegate
extension ExperienceFormController: LabelSwitchDelegate {
    func getValueSwitch() {
        if (jobStatus.switchButton.isOn){
            jobPeriod.endDatePicker.isEnabled = true
        } else {
            jobPeriod.endDatePicker.isEnabled = false
        }
    }
}

extension ExperienceFormController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView){
        expPlaceholder = self.viewModel?.getExpPh()
        if (jobSummary.textView.text.lowercased() == expPlaceholder?.jobDesc_ph?.lowercased()){
            jobSummary.textView.text = ""
        }
        jobSummary.textView.textColor = .black
    }
}

//MARK: Initial Setup
extension ExperienceFormController {
    func setup(){
        self.title = "Professional Experience"
        expPlaceholder = self.viewModel?.getExpPh()
        expSuggestion = self.viewModel?.getExpSuggestion()
        companyName.titleLabel.text = "Company Name*"
        jobTitle.titleLabel.text = "Job Title*"
        jobStatus.titleLabel.text = "Job Status*"
        jobStatus.switchTitle.text = "Currently Working Here"
        jobStatus.delegate = self
        jobPeriod.titleLabel.text = "Job Period*"
        jobSummary.titleLabel.text = "Job Summary*"
        jobSummary.cueLabel.text = expSuggestion?.jobDescSuggest
        jobSummary.textView.delegate = self
        
        if dataFrom == "edit"{
            if experience == nil {
                companyName.textField.placeholder = expPlaceholder?.companyName_ph
                jobTitle.textField.placeholder = expPlaceholder?.jobTitle_ph
                jobSummary.textView.text = expPlaceholder?.jobDesc_ph
                jobSummary.textView.textColor = .lightGray
                addExpBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add Experience")
            } else {
                companyName.textField.text = experience?.jobCompanyName
                jobTitle.textField.text = experience?.jobTitle
                jobSummary.textView.text = experience?.jobDesc
                jobStatus.switchButton.isOn = ((experience?.jobStatus) == true)
                jobPeriod.startDatePicker.date = experience?.jobStartDate ?? Date()
                jobPeriod.endDatePicker.date = experience?.jobEndDate ?? Date()
                addExpBtn.dsLongUnfilledButton(isDelete: true, text: "Delete Experience")
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateExp(sender:)))
            }
            
            if experience?.jobDesc != "" {
                jobSummary.textView.textColor = .black
            }
            
        } else {
            companyName.textField.placeholder = expPlaceholder?.companyName_ph
            jobTitle.textField.placeholder = expPlaceholder?.jobTitle_ph
            jobSummary.textView.text = expPlaceholder?.jobDesc_ph
            jobSummary.textView.textColor = .lightGray
            addExpBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add Experience")
        }
    }
}
