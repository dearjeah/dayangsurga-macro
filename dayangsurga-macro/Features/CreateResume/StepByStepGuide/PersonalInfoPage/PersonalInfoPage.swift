//
//  PersonalInfoPage.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol PersonalInfoPageDelegate: AnyObject {
    func setPlaceHolder(fullName : String)

}

class PersonalInfoPage: UIView{
    
    @IBOutlet weak var fullNameField: LabelWithTextField!
    @IBOutlet weak var emailField: LabelWithTextField!
    @IBOutlet weak var phoneField: LabelWithTextField!
    @IBOutlet weak var locationField: LabelWithTextField!
    @IBOutlet weak var summaryField: LabelWithTextView!
    
    weak var delegate: PersonalInfoPageDelegate?

    
    func setup(dlgt: PersonalInfoPageDelegate) {
        self.delegate = dlgt
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        setup()
    }
    
    convenience init(fullName: String, email: String, phone: String, location: String, summary: String) {
        self.init()
        fullNameField.textField.text = fullName
        emailField.textField.text = email
        phoneField.textField.text = phone
        locationField.textField.text = location
        self.summaryField.textView.delegate = self
//        MARK: cannot be assigned twice. Notes: textview don't have placeholder
//        summaryField.textView.text = summary
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
    
    func setup() {

        fullNameField.titleLabel.text = "Full Name*"
        emailField.titleLabel.text = "Email*"
        phoneField.titleLabel.text = "Phone Number*"
        locationField.titleLabel.text = "Location*"
        summaryField.titleLabel.text = "Summary*"
        summaryField.cueLabel.text = "Tell us about who you are and what you do that fits the job you're applying for, make sure you use action verbs."
        
        //MARK: Implement with protocol delegate for loose coupling
        if let personalInfoPlaceholder = PersonalInformationPlaceholderRepository.shared.getPIPhById(pi_ph_id: 1) {
            fullNameField.textField.placeholder =  personalInfoPlaceholder.name_ph
            emailField.textField.placeholder = personalInfoPlaceholder.email_ph
            phoneField.textField.placeholder = personalInfoPlaceholder.phoneNumber_ph
            locationField.textField.placeholder = personalInfoPlaceholder.address_ph
            summaryField.textView.text = personalInfoPlaceholder.summary_ph
            summaryField.textView.textColor = .lightGray
            
            
        }
      
     
    }
    
    func goToNextStep() {
        
    }
  
}


extension PersonalInfoPage :  UITextViewDelegate{

    func textViewDidChange(_ textView: UITextView){
        if let personalInfoPlaceholder = PersonalInformationPlaceholderRepository.shared.getPIPhById(pi_ph_id: 1) {
            if (summaryField.textView.text.count  + 1 == (personalInfoPlaceholder.summary_ph?.count)){
                summaryField.textView.text = ""
            }
        }
        summaryField.textView.textColor = .black
    }
}
