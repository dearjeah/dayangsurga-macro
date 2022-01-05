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
    
    var dataFrom = String()
    var expPh: Experience_Placeholder?
    var expSuggest: Experience_Suggestion?
    var exp: Experience? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UPExperienceFormViewModel()
        setup()
        getInitialData()
        hideKeyboardWhenTappedAround()
        
        self.jobSummaryView.textView.delegate = self
        self.jobStatusView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addAction(_ sender: Any){
        addOrDeleteExp()
    }
    
    @IBAction func unwindToUPExpList(_ unwindSegue: UIStoryboardSegue){
        
    }
}

//MARK: Initial Setup
extension UPExperiecenFormVC{
    func setup(){
        self.title = "Experience"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.jobSummaryView.textView.delegate = self
        self.jobStatusView.delegate = self
        expPh = self.viewModel?.getExpPh()
        expSuggest = self.viewModel?.getExpSuggest()
        companyNameView.titleLabel.text = "Company Name"
        jobTitleView.titleLabel.text = "Job Title*"
        jobStatusView.titleLabel.text = "Job Status*"
        jobStatusView.switchTitle.text = "Currently Working Here"
        jobPeriodView.titleLabel.text = "Job Title*"
        jobSummaryView.titleLabel.text = "Job Summary*"
        jobSummaryView.cueLabel.text = expSuggest?.jobDescSuggest
        jobPeriodView.endDatePicker.maximumDate = Date()
        getValueSwitch()
        
        if dataFrom == "edit"{
            if exp == nil{
                companyNameView.textField.placeholder = expPh?.companyName_ph
                jobTitleView.textField.placeholder = expPh?.jobTitle_ph
                jobSummaryView.textView.text = expPh?.jobDesc_ph
                jobSummaryView.textView.textColor = .lightGray
                addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Experience")
            }else{
                companyNameView.textField.text = exp?.jobCompanyName
                jobTitleView.textField.text = exp?.jobTitle
                jobSummaryView.textView.text = exp?.jobDesc
                jobStatusView.switchButton.isOn = ((exp?.jobStatus) == true)
                jobPeriodView.startDatePicker.date = exp?.jobStartDate ?? Date()
                jobPeriodView.endDatePicker.date = exp?.jobEndDate ?? Date()
                addOrDeleteButton.dsLongUnfilledButton(isDelete: true, text: "Delete Experience")
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(self.updateExp(sender:)))
            }
            
            if exp?.jobDesc != "" {
                jobSummaryView.textView.textColor = .black
            }
        }else{
            companyNameView.textField.placeholder = expPh?.companyName_ph
            jobTitleView.textField.placeholder = expPh?.jobTitle_ph
            jobSummaryView.textView.text = expPh?.jobDesc_ph
            jobSummaryView.textView.textColor = .lightGray
            addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Experience")
        }
    }
}

//MARK: Core Data
extension UPExperiecenFormVC{
    func getInitialData(){
        expPh = self.viewModel?.getExpPh()
        expSuggest = self.viewModel?.getExpSuggest()
    }
    
    func addOrDeleteExp(){
        if !alertForCheckTF(){
            if dataFrom == "Add"{
                guard let data = self.viewModel?.addExp(expId: UUID().uuidString,
                                                        title: jobTitleView.textField.text ?? "",
                                                        jobDesc: jobSummaryView.textView.text,
                                                        company: companyNameView.textField.text ?? "",
                                                        startDate: jobPeriodView.startDatePicker.date,
                                                        endDate: jobPeriodView.endDatePicker.date,
                                                        status: jobStatusView.switchButton.isOn,
                                                        isSelected: true) else {return errorSaveData(from: "Save")}
                if data{
                    performSegue(withIdentifier: "backToUPExpList", sender: self)
                }else{
                    errorSaveData(from: "Save")
                }
            } else {
                showAlertForDelete()
            }
        }
    }
    
    @objc func updateExp(sender: UIBarButtonItem){
        if !alertForCheckTF() {
            guard let expId = exp?.exp_id else { return }
            guard let data = self.viewModel?.updateExp(expId: expId,
                                                           title: jobTitleView.textField.text ?? "",
                                                           jobDesc: jobSummaryView.textView.text,
                                                           company: companyNameView.textField.text ?? "",
                                                           startDate: jobPeriodView.startDatePicker.date,
                                                           endDate: jobPeriodView.endDatePicker.date,
                                                           status: jobStatusView.switchButton.isOn,
                                                           isSelected: true
            ) else { return errorSaveData(from: "Update") }
            
            if data {
                performSegue(withIdentifier: "backToUPExpList", sender: self)
            } else {
                errorSaveData(from: "Update")
            }
        }
    }
    
    func deleteExpData(){
        guard let data = self.viewModel?.deleteExp(dataExp: exp ?? Experience()) else { return errorSaveData(from: "Delete")}
        if data{
            performSegue(withIdentifier: "backToUPExpList", sender: self)
        }else{
            errorSaveData(from: "Delete")
        }
    }
}

//MARK: Alert
extension UPExperiecenFormVC{
    func alertForCheckTF() -> Bool {
        if ((companyNameView.textField.text?.isEmpty) != false) || ((jobTitleView.textField.text?.isEmpty) != false) || ((jobSummaryView.textView.text?.isEmpty) != false){
            showAlert(title: "Field Can't Be Empty", msg: "You must fill in every mandatory fields in this form.", style: .default, titleAction: "OK")
            return true
        } else {
            return false
        }
    }
    
    func showAlertForDelete(){
        showAlertDelete(title: "Delete Data?", msg: "You will not be able to recover it.", completionBlock: {action in self.deleteExpData()})
    }
    
    func errorSaveData(from: String){
        showAlert(title: "Unable to Save Data", msg: "Your data is not saved. Please try again later", style: .default, titleAction: "OK")
    }
}

//MARK: Delegates
extension UPExperiecenFormVC: UITextViewDelegate, LabelSwitchDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        expPh = self.viewModel?.getExpPh()
        if(jobSummaryView.textView.text.lowercased() == expPh?.jobDesc_ph?.lowercased()){
            jobSummaryView.textView.text = ""
        }
        jobSummaryView.textView.textColor = .black
    }
    
    func getValueSwitch() {
        if(jobStatusView.switchButton.isOn){
            jobPeriodView.endDatePicker.isUserInteractionEnabled = false
        }else{
            jobPeriodView.endDatePicker.isUserInteractionEnabled = true
        }
    }
}
