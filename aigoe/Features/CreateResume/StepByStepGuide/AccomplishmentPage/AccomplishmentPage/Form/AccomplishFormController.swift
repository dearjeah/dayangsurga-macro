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
    @IBOutlet weak var statusView: LabelWithSwitch!
    @IBOutlet weak var endDateView: LabelWithDate!
    @IBOutlet weak var issuerView: LabelWithTextField!
    @IBOutlet weak var addOrDeleteButton: UIButton!
    @IBOutlet weak var addtionalCertificateLabel: UILabel!
    var accomplish: Accomplishment? = nil
    var accomplishPh: Accomplish_Placeholder?
    var accomplishSuggest: Accomplishment_Suggest?
    var dataFrom = String()
    var accomId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = AccomplishFormViewModel()
        accomplishPh = self.viewModel?.getAccomplishPh()
        accomplishSuggest = self.viewModel?.getAccomplishSuggestion()
        setup()
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
                    endDate: endDateView.datePicker.date,
                    status: statusView.switchButton.isOn,
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

    func deleteAccomplishData(){
        guard let data = self.viewModel?.deleteAccomplishData(dataAccomplish: accomplish) else { return }
        if data {
            self.navigationController?.popViewController(animated: false)
        } else {
            errorSaveData(from: "Delete")
        }
    }

    @objc func updateAccomplish(sender: UIBarButtonItem) {
        if !alertForCheckTF() {
            guard let accomId = accomplish?.accomplishment_id else { return }
            guard let data = self.viewModel?.updateAccomp(accompId: accomId,
                                                          title: certificateNameView.textField.text ?? "",
                                                          givenDate: dateView.datePicker.date,
                                                          endDate: dateView.datePicker.date,
                                                          status: statusView.switchButton.isOn,
                                                          issuer: issuerView.textField.text ?? "",
                                                          desc: ""
            ) else { return errorSaveData(from: "Update") }
            if data {
                performSegue(withIdentifier: "backToStepVC", sender: self)
            } else {
                errorSaveData(from: "Update")
            }
        }
    }
    
}
//MARK: ALERT
extension AccomplishFormController {
    func errorSaveData(from: String){
        showAlert(title: "Unable to \(from) Data", msg: "Your data is not saved. Please try again later", style: .default, titleAction: "OK")
    }
    
    func alertForCheckTF() -> Bool {
        if ((certificateNameView.textField.text?.isEmpty) != false) || ((issuerView.textField.text?.isEmpty) != false) {
            showAlert(title: "Field Can't Be Empty", msg: "You must fill in every mandatory fields in this form.", style: .default, titleAction: "OK")
            return true
        } else {
            return false
        }
    }
    
    func showAlertForDelete(){
        showAlertDelete(title: "Delete Data?", msg: "You will not be able to recover it.", completionBlock: {action in self.deleteAccomplishData()})
    }
}

//MARK: Delegate
extension AccomplishFormController: LabelSwitchDelegate {
    func getValueSwitch() {
        if (statusView.switchButton.isOn){
            endDateView.datePicker.isUserInteractionEnabled = false
        } else {
            endDateView.datePicker.isUserInteractionEnabled = true
        }
    }
}

//MARK: Initial Setup
extension AccomplishFormController {
    func setup(){
        self.title = "Accomplishment"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.viewModel = AccomplishFormViewModel()
        accomplishPh = self.viewModel?.getAccomplishPh()
        accomplishSuggest = self.viewModel?.getAccomplishSuggestion()
        certificateNameView.titleLabel.text = "Certificate/Award Name*"
        addtionalCertificateLabel.text = accomplishSuggest?.title
        dateView.dateTitle.text = "Issued Date*"
        statusView.titleLabel.text = "Certificate/Award Status"
        statusView.switchTitle.text = "Currently Valid"
        statusView.delegate = self
        endDateView.dateTitle.text = "Expiration Date*"
        endDateView.datePicker.maximumDate = Date()
        issuerView.titleLabel.text = "Issuer*"
        getValueSwitch()
        if dataFrom == "edit" {
            if accomplish == nil {
                certificateNameView.textField.placeholder = accomplishPh?.title_ph
                issuerView.textField.placeholder = accomplishPh?.given_date_ph
                addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Accomplishment")
            } else {
                certificateNameView.textField.text = accomplish?.title
                issuerView.textField.text = accomplish?.issuer
                dateView.datePicker.date = accomplish?.given_date ?? Date()
                statusView.switchButton.isOn = ((accomplish?.status) == true)
                endDateView.datePicker.date = accomplish?.end_date ?? Date()
                addOrDeleteButton.dsLongUnfilledButton(isDelete: true, text: "Delete Accomplishment")
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateAccomplish(sender:)))
            }
        } else {
            certificateNameView.textField.placeholder = accomplishPh?.title_ph
            issuerView.textField.placeholder = accomplishPh?.given_date_ph
            addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Accomplishment")
        }
    }
}
