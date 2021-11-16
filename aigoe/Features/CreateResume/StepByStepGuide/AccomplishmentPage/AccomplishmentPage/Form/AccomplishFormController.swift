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
    var dataFrom = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = AccomplishFormViewModel()
        accomplishPh = self.viewModel?.getAccomplishPh()
        accomplishSuggest = self.viewModel?.getAccomplishSuggestion()
        setView()
        hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? StepByStepGuideViewController {
            vc.formSource = "accomplishment"
        }
    }
    
    @IBAction func buttonWasPressed(_ sender: Any) {
        if !alertForCheckTF() {
            if accomplish == nil{
                guard let data = self.viewModel?.addAccomp(
                    title: certificateNameView.textField.text ?? "",
                    givenDate:  dateView.datePicker.date,
                    issuer: issuerView.textField.text ?? "",
                    desc: ""
                ) else { return errorSaveData(from: "Save") }
                if data {
                    performSegue(withIdentifier: "backToStepVC", sender: self)
                } else {
                    errorSaveData(from: "Save")
                }
            } else { // update and edit
                showAlertForDelete()
            }
        }
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
    
        if dataFrom == "edit" {
            if accomplish == nil {
                certificateNameView.textField.placeholder = accomplishPh?.title_ph
                issuerView.textField.placeholder = accomplishPh?.given_date_ph
                addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Accomplishment")
            } else {
                certificateNameView.textField.text = accomplish?.title
                issuerView.textField.text = accomplish?.issuer
                dateView.datePicker.date = accomplish?.given_date ?? Date()
                addOrDeleteButton.dsLongUnfilledButton(isDelete: true, text: "Delete Accomplishment")
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateAccomplish(sender:)))
            }
        } else {
            certificateNameView.textField.placeholder = accomplishPh?.title_ph
            issuerView.textField.placeholder = accomplishPh?.given_date_ph
            addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Accomplishment")
        }
    }
    
    func alertForCheckTF() -> Bool {
        if ((certificateNameView.textField.text?.isEmpty) != false) || ((issuerView.textField.text?.isEmpty) != false) {
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
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in self.deleteAccomplishData()}))
        self.present(alert, animated: true, completion: nil)
    }
    // for delete and reload
    func deleteAccomplishData(){
        self.viewModel?.deleteAccomplishData(dataAccomplish: accomplish)
        self.navigationController?.popViewController(animated: false)
    }
    @objc func updateAccomplish(sender: UIBarButtonItem) {
        AccomplishmentRepository.shared.updateAccomplishment(accomId: UUID().uuidString,
                                                             userId: 0,
                                                             title: certificateNameView.textField.text ?? String(),
                                                             givenDate: dateView.datePicker.date,
                                                             issuer: issuerView.textField.text ?? String(),
                                                             desc: "",
                                                             isSelected: true)
        let storyboard = UIStoryboard(name: "TestAccomplish", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToTestAccomplish") as! TestAccomplishController
        vc.navigationItem.setHidesBackButton(true, animated:false)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}
//MARK: ALERT
extension AccomplishFormController {
    func errorSaveData(from: String){
        let alert = UIAlertController(title: "Unable to \(from) Data", message: "Your data is not saved. Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
