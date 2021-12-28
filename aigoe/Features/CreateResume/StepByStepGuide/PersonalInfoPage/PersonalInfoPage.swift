//
//  PersonalInfoPage.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol PersonalInfoPageDelegate: AnyObject {
    func isAllTextfieldFilled(was: Bool, data: PersonalInfo)

}

class PersonalInfoPage: UIView{
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fullNameField: LabelWithTextField!
    @IBOutlet weak var emailField: LabelWithTextField!
    @IBOutlet weak var phoneField: LabelWithTextField!
    @IBOutlet weak var locationField: LabelWithTextField!
    @IBOutlet weak var summaryField: LabelWithTextView!
    
    weak var delegate: PersonalInfoPageDelegate?
    var userData = User()
    var isFromCreate = Bool()

    func setup(dlgt: PersonalInfoPageDelegate) {
        self.delegate = dlgt
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init(data: User, isCreate: Bool) {
        self.init()
        
        userData = data
        isFromCreate = isCreate
        setup()
        self.summaryField.textView.delegate = self
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "PersonalInfoPage") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}

//MARK: Initial Setup
extension PersonalInfoPage {
    func setup() {
        fullNameField.titleLabel.text = "Full Name*"
        emailField.titleLabel.text = "Email*"
        phoneField.titleLabel.text = "Phone Number*"
        locationField.titleLabel.text = "Location*"
        summaryField.titleLabel.text = "Summary*"
        summaryField.cueLabel.text = "Tell us about who you are and what you do that fits the job you're applying for, make sure you use action verbs."
        emailField.textField.keyboardType = .emailAddress
        phoneField.textField.keyboardType = .numberPad
        
        //MARK: Implement with protocol delegate for loose coupling
        if let personalInfoPlaceholder = PersonalInformationPlaceholderRepository.shared.getPIPhById(pi_ph_id: 1) {
            fullNameField.textField.placeholder =  personalInfoPlaceholder.name_ph
            emailField.textField.placeholder = personalInfoPlaceholder.email_ph
            phoneField.textField.placeholder = personalInfoPlaceholder.phoneNumber_ph
            locationField.textField.placeholder = personalInfoPlaceholder.address_ph
            summaryField.textView.text = personalInfoPlaceholder.summary_ph
            summaryField.textView.textColor = .lightGray
        }
        
        if userData.username != "" {
            fullNameField.textField.text =  userData.username
            emailField.textField.text = userData.email
            phoneField.textField.text = userData.phoneNumber
            locationField.textField.text = userData.location
            summaryField.textView.text = userData.summary
            summaryField.textView.textColor = .black
        }
        
        fullNameField.setup(dlgt: self)
        emailField.setup(dlgt: self)
        phoneField.setup(dlgt: self)
        locationField.setup(dlgt: self)
        
    }
    
    func checkAllFieldValue() -> Bool {
        if fullNameField.textField.text?.isEmpty == false
            && emailField.textField.text?.isEmpty == false
            && phoneField.textField.text?.isEmpty == false
            && locationField.textField.text?.isEmpty == false
            && summaryField.textView.text.isEmpty == false {
            return true
        }
        return false
    }
}
//MARK: Core Data
extension PersonalInfoPage {
    func saveToCoreData() {
        if UserRepository.shared.getUserById(id: 0) != nil{
            UserRepository.shared.updateUser(id: 0, newName: fullNameField.textField.text ?? "", newPhoneNumber: phoneField.textField.text ?? "", newEmail: emailField.textField.text ?? "" , newLocation: locationField.textField.text ?? "", newSummary: summaryField.textView.text ?? "")
        } else {
            UserRepository.shared.createUser(user_id: 0, username: fullNameField.textField.text ?? "", phoneNumber: phoneField.textField.text ?? "", email: emailField.textField.text ?? "", location: locationField.textField.text ?? "", summary: summaryField.textView.text ?? "")
        }
    }
}

//MARK: Delegate
extension PersonalInfoPage :  UITextViewDelegate, LabelWithTextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let personalInfoPlaceholder = PersonalInformationPlaceholderRepository.shared.getPIPhById(pi_ph_id: 1) {
            if (summaryField.textView.text.lowercased()  == (personalInfoPlaceholder.summary_ph?.lowercased())){
                summaryField.textView.text = ""
            }
        }
        summaryField.textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let tmp = checkAllFieldValue()
        if tmp {
            let data = PersonalInfo(
                id: 0,
                name: fullNameField.textField.text ?? "",
                email: emailField.textField.text ?? "",
                phoneNumber: phoneField.textField.text ?? "",
                location: locationField.textField.text ?? "",
                summary: summaryField.textView.text ?? ""
            )
            delegate?.isAllTextfieldFilled(was: true, data: data)
        }
    }
    
    func isTextfieldFilled(was: Bool) {
        if was {
            let tmp = checkAllFieldValue()
            if tmp {
                let data = PersonalInfo(
                    id: 0,
                    name: fullNameField.textField.text ?? "",
                    email: emailField.textField.text ?? "",
                    phoneNumber: phoneField.textField.text ?? "",
                    location: locationField.textField.text ?? "",
                    summary: summaryField.textView.text ?? ""
                )
                delegate?.isAllTextfieldFilled(was: true, data: data)
            }
        }
    }
}
