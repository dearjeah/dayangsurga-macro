//
//  AccomplishFormController.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 01/11/21.
//

import UIKit

class AccomplishFormController: MVVMViewController<AccomplishFormViewModel> {

    @IBOutlet weak var backgroundView: DesignableButton!
    @IBOutlet weak var certificateNameView: LabelWithTextField!
    @IBOutlet weak var dateView: LabelWithDate!
    @IBOutlet weak var issuerView: LabelWithTextField!
    @IBOutlet weak var addOrDeleteButton: UIButton!
    @IBOutlet weak var addtionalCertificateLabel: UILabel!
    var accomplish: Accomplishment? = nil
    var accomplishPh: Accomplish_Placeholder?
    var accomplishSuggest: Accomplishment_Suggest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = AccomplishFormViewModel()
        accomplishPh = self.viewModel?.getAccomplishPh()
        accomplishSuggest = self.viewModel?.getAccomplishSuggestion()
        setView()
        hideKeyboardWhenTappedAround()
        //tes coding tambahan
    }
    
    func setView(){
        self.title = "Accomplishment"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.viewModel = AccomplishFormViewModel()
        accomplishPh = self.viewModel?.getAccomplishPh()
        accomplishSuggest = self.viewModel?.getAccomplishSuggestion()
        certificateNameView.titleLabel.text = "Certificate/Award Name*"
        addtionalCertificateLabel.text = accomplishSuggest?.title
        dateView.titleLabel.text = "Qualification*"
        issuerView.titleLabel.text = "Issuer*"
        
        certificateNameView.textField.placeholder = accomplishPh?.title_ph
        issuerView.textField.placeholder = accomplishPh?.given_date_ph
        addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add")
    }
    
}
