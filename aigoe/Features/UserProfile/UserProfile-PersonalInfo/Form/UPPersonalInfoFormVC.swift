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
    
    var ph: PersonalInformation_Placeholder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = UPPersonalInfoFormViewModel()
        getInitialData()
        setup()
        hideKeyboardWhenTappedAround()
    }
}

// MARK: Initial Setup
extension UPPersonalInfoFormVC {
    func setup(){
//        self.navigationItem.backButtonTitle = "Test"
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//        navigationController?.navigationItem.backBarButtonItem?.tintColor = .white
//        navigationController?.navigationItem.backBarButtonItem?.title = " "
//        navigationItem.backBarButtonItem?.tintColor = UIColor.primaryWhite
//        navigationItem.backBarButtonItem?.title = ""
        
        formView.titleLbl.isHidden = true
        addEditBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add Personal Information")
        
        formView.fullNameField.titleLabel.text = "Full Name*"
        formView.emailField.titleLabel.text = "Email*"
        formView.phoneField.titleLabel.text = "Phone Number*"
        formView.locationField.titleLabel.text = "Location*"
        formView.summaryField.titleLabel.text = "Summary*"
        formView.summaryField.cueLabel.text = "Tell us about who you are and what you do that fits the job you're applying for, make sure you use action verbs."
        formView.emailField.textField.keyboardType = .emailAddress
        formView.phoneField.textField.keyboardType = .numberPad
        
        formView.fullNameField.textField.placeholder = ph?.name_ph
        formView.emailField.textField.placeholder = ph?.email_ph
        formView.phoneField.textField.placeholder = ph?.phoneNumber_ph
        formView.locationField.textField.placeholder = ph?.address_ph
        formView.summaryField.textView.text = ph?.summary_ph
        formView.summaryField.textView.textColor = .lightGray
        
        formView.summaryField.textView.delegate = self
        
    }
    
    func checkAllFieldValue() -> Bool {
        if formView.fullNameField.textField.text?.isEmpty == false
            && formView.emailField.textField.text?.isEmpty == false
            && formView.phoneField.textField.text?.isEmpty == false
            && formView.locationField.textField.text?.isEmpty == false
            && formView.summaryField.textView.text.isEmpty == false {
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
}
