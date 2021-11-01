//
//  AccomplishFormController.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 01/11/21.
//

import UIKit

class AccomplishFormController: UIViewController {

    @IBOutlet weak var backgroundView: DesignableButton!
    @IBOutlet weak var certificateNameView: LabelWithTextField!
    @IBOutlet weak var dateView: LabelWithDate!
    @IBOutlet weak var issuerView: LabelWithTextField!
    @IBOutlet weak var addOrDeleteButton: UIButton!
    @IBOutlet weak var addtionalCertificateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setupForm()
        hideKeyboardWhenTappedAround()
    }
    
    func setView(){
        self.title = "Accomplishment"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add")
        addtionalCertificateLabel.text = "Only include certificates or awards that are relevant to the job you're applying for."
    }
    
    func setupForm(){
        // for accomplishment name
        certificateNameView.titleLabel.text = "Certificate/Award Name*"
        certificateNameView.textField.placeholder = "e.g. UI/UX & Product Design"
        
        // for accomplishment date
        dateView.titleLabel.text = "Qualification*"
        
        // for issuer accomplishment
        issuerView.titleLabel.text = "Issuer*"
        issuerView.textField.placeholder = "e.g. Dayang.co"
    }
    
}
