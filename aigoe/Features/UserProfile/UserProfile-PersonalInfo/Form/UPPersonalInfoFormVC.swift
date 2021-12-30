//
//  UPPersonalInfoFormVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPPersonalInfoFormVC: MVVMViewController<UPPersonalInfoFormViewModel> {
    
    @IBOutlet weak var formView: PersonalInfoPage!
    @IBOutlet weak var addEditBtn: UIButton!
    
    var personalInfo: User? = nil
    var dataSource: String? = ""
    var totalData = Int()
    
    var ph: PersonalInformation_Placeholder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = UPPersonalInfoFormViewModel()
        getInitialData()
        setup()
        hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToList" {
            let vc = segue.destination as? UPPersonalInfoListVC
            vc?.navigationItem.hidesBackButton = true
        }
    }
    
    @IBAction func saveorDeleteAction(_ sender: Any) {
        addOrDelete()
    }
}

// MARK: Initial Setup
extension UPPersonalInfoFormVC {
    func setup(){
        self.title = "Personal Information"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        formView.viewTitle.isHidden = true
        
        formView.fullNameField.titleLabel.text = "Full Name*"
        formView.emailField.titleLabel.text = "Email*"
        formView.phoneField.titleLabel.text = "Phone Number*"
        formView.locationField.titleLabel.text = "Location*"
        formView.summaryField.titleLabel.text = "Summary*"
        formView.summaryField.cueLabel.text = "Tell us about who you are and what you do that fits the job you're applying for, make sure you use action verbs."
        formView.emailField.textField.keyboardType = .emailAddress
        formView.phoneField.textField.keyboardType = .numberPad
        
        formView.summaryField.textView.delegate = self
        
        if dataSource == "Edit" {
            if personalInfo == nil {
                formView.fullNameField.textField.placeholder = ph?.name_ph
                formView.emailField.textField.placeholder = ph?.email_ph
                formView.phoneField.textField.placeholder = ph?.phoneNumber_ph
                formView.locationField.textField.placeholder = ph?.address_ph
                formView.summaryField.textView.text = ph?.summary_ph
                formView.summaryField.textView.textColor = .lightGray
                addEditBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add Personal Information")
            } else {
                formView.fullNameField.textField.text = personalInfo?.username
                formView.emailField.textField.text = personalInfo?.email
                formView.phoneField.textField.text = personalInfo?.phoneNumber
                formView.locationField.textField.text = personalInfo?.location
                formView.summaryField.textView.text = personalInfo?.summary
                formView.summaryField.textView.textColor = .black
                
                navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updatePI(sender:)))
                addEditBtn.dsLongUnfilledButton(isDelete: true, text: "Delete Personal Information")
            }
        } else {
            formView.fullNameField.textField.placeholder = ph?.name_ph
            formView.emailField.textField.placeholder = ph?.email_ph
            formView.phoneField.textField.placeholder = ph?.phoneNumber_ph
            formView.locationField.textField.placeholder = ph?.address_ph
            formView.summaryField.textView.text = ph?.summary_ph
            formView.summaryField.textView.textColor = .lightGray
            addEditBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add Personal Information")
        }
        
        for constraint in formView.designableView.constraints{
            if constraint.identifier == "topConstraint" {
                constraint.constant = -30
            }
        }
        formView.layoutIfNeeded()
    }
    
    func checkAllFieldValue() -> Bool {
        if ((formView.fullNameField.textField.text?.isEmpty != false)
            || formView.emailField.textField.text?.isEmpty != false
            || formView.phoneField.textField.text?.isEmpty != false
            || formView.locationField.textField.text?.isEmpty != false
            || formView.summaryField.textView.text.isEmpty != false) {
            showAlert(title: "Field Can't Be Empty", msg: "You must fill in every mandatory fields in this form.", style: .default, titleAction: "OK")
            return true
        }
        return false
    }
}

// MARK: Core Data
extension UPPersonalInfoFormVC {
    func getInitialData() {
        ph = self.viewModel?.getPhbyID()
    }
    
    func addOrDelete(){
        if !checkAllFieldValue() {
            if dataSource == "Add" {
                let data: ()? = self.viewModel?.createPersonalInformation(userId: totalData + 1,
                                                                          username: formView.fullNameField.textField.text ?? "",
                                                                          phoneNumber: formView.phoneField.textField.text ?? "",
                                                                          email: formView.emailField.textField.text ?? "",
                                                                          loc: formView.locationField.textField.text ?? "",
                                                                          sum: formView.summaryField.textView.text ?? "")
                if (data != nil) {
                    performSegue(withIdentifier: "backToList", sender: self)
                } else {
                    errorSaveData()
                }
            } else {
                showAlertDelete(title: "Delete Data?", msg: "You will not be able to recover it.", completionBlock: {action in self.deletePIData()})
            }
        }
        
    }
    
    @objc func updatePI(sender: UIBarButtonItem) {
        if !checkAllFieldValue() {
            let data: ()? = self.viewModel?.updatePersonalInformation(userId: Int(personalInfo?.user_id ?? 0),
                                                                      username: formView.fullNameField.textField.text ?? "",
                                                                      phoneNumber: formView.phoneField.textField.text ?? "",
                                                                      email: formView.emailField.textField.text ?? "",
                                                                      loc: formView.locationField.textField.text ?? "",
                                                                      sum: formView.summaryField.textView.text ?? "")
            if (data != nil) {
                performSegue(withIdentifier: "backToList", sender: self)
            } else {
                errorSaveData()
            }
        }
    }
    
}

// MARK: Delegate
extension UPPersonalInfoFormVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let personalInfoPlaceholder = PersonalInformationPlaceholderRepository.shared.getPIPhById(pi_ph_id: 1) {
            if (formView.summaryField.textView.text.lowercased()  == (personalInfoPlaceholder.summary_ph?.lowercased())){
                formView.summaryField.textView.text = ""
            }
        }
        formView.summaryField.textView.textColor = .black
    }
    
}

// MARK: Alert
extension UPPersonalInfoFormVC {
    func deletePIData(){
        let data: ()? = self.viewModel?.deletePersonalInformation(data: personalInfo ?? User())
        if (data != nil) {
            performSegue(withIdentifier: "backToList", sender: self)
        } else {
            errorSaveData()
        }
    }
    
    func errorSaveData(){
        showAlert(title: "Unable to Save Data", msg: "Your data is not saved. Please try again later", style: .default, titleAction: "OK")
    }
    
    
}
