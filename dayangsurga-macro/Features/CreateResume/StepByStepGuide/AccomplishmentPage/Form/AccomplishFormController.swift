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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setupForm()
        hideKeyboardWhenTappedAround()
//        createLabel()
    }
    
    func setView(){
        self.title = "Accomplishment"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Accomplishment")
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
    
    func createLabel(){
        let messagelabel = UILabel(frame: CGRect(x: 10,
                                                 y: certificateNameView.frame.size.height - 70,
                                                 width: backgroundView.frame.size.width - 40,
                                                 height: 35))
        messagelabel.textAlignment = .left
        messagelabel.numberOfLines = 0
        messagelabel.text = "Only include certificates or awards that are relevant to the job you're applying for."
        messagelabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        self.backgroundView.addSubview(messagelabel)
    }
    
}
