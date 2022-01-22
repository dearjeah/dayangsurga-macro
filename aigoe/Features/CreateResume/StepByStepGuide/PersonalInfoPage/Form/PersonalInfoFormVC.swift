//
//  PersonalInfoFormVC.swift
//  aigoe
//
//  Created by Delvina Janice on 05/01/22.
//

import UIKit
import AVFAudio

class PersonalInfoFormVC: MVVMViewController<PersonalInfoFormViewModel> {

    @IBOutlet weak var personalInfoForm: PersonalInfoPage!
    @IBOutlet weak var addDeleteButton: UIButton!
    
    weak var delegate: EduFormDelegate?
    var personalInfoData: Personal_Info? = nil
    var piPlaceholder: PersonalInformation_Placeholder?
    var piSuggestion: PersonalInformation_Suggestion?
    var placeholderLabel : UILabel!
    var dataFrom = ""
    var currentUserId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    @IBAction func addDeletePressed(_ sender: UIButton) {
        tapToAddDeleteButton()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? StepByStepGuideViewController {
            vc.formSource = "personalInfo"
        }
    }
}

extension PersonalInfoFormVC {
    func initialSetup() {
        personalInfoForm.personalInfoData = personalInfoData
        personalInfoForm.dataFrom = dataFrom
        personalInfoForm.setup()
        buttonStyle()
        navigationSetup()
        self.viewModel = PersonalInfoFormViewModel()
        
        if personalInfoData != nil {
            personalInfoForm.personalInfoData = personalInfoData
        }
    }
    
    func navigationSetup(){
        self.title = "Personal Information"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func buttonStyle() {
        if dataFrom == "add" {
            addDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Personal Information")
        } else {
            addDeleteButton.dsLongUnfilledButton(isDelete: true, text: "Delete Personal Information")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateEdu(sender:)))
        }
    }

}

//MARK: Alert
extension PersonalInfoFormVC {
    func showAlertForDelete(){
        showAlertDelete(title: "Delete Data?", msg: "You will not be able to recover it.", completionBlock: {action in self.deletePersonalInfoData()})
    }
    
    func errorSaveData(from: String){
        showAlert(title: "Unable to \(from) Data", msg: "Your data is not saved. Please try again later", style: .default, titleAction: "OK")
    }
    func filledCantBeEmpty(){
        showAlert(title: "Field Can't Be Empty", msg: "You must fill in every mandatory fields in this form.", style: .default, titleAction: "OK")
    }
}

//MARK: Core Data Operation
extension PersonalInfoFormVC{
    func tapToAddDeleteButton(){
        if personalInfoForm.checkAllFieldValue() {
            if dataFrom == "add" {
                saveData(from: "Save")
            } else {
                showAlertForDelete()
            }
        } else {
            filledCantBeEmpty()
        }
    }
 
    func saveData(from: String) {
        var result = false
        if from == "Save"{
            guard let data = self.viewModel?.addPersonalInfo(
                userId: currentUserId,
                name: personalInfoForm.fullNameField.textField.text ?? "",
                phone: personalInfoForm.phoneField.textField.text ?? "",
                email: personalInfoForm.emailField.textField.text ?? "",
                location: personalInfoForm.locationField.textField.text ?? "",
                summary: personalInfoForm.summaryField.textView.text ?? "") else { return errorSaveData(from: "Save") }
            result = data
        } else {
            guard let data = self.viewModel?.updatePersonalInfo(
                id: personalInfoData?.personalInfo_id ?? "",
                name: personalInfoForm.fullNameField.textField.text ?? "",
                phone: personalInfoForm.phoneField.textField.text ?? "",
                email: personalInfoForm.emailField.textField.text ?? "",
                location: personalInfoForm.locationField.textField.text ?? "",
                summary: personalInfoForm.summaryField.textView.text ?? "") else { return errorSaveData(from: "Update") }
            result = data
        }
        
        if result {
            performSegue(withIdentifier: "backToStepVC", sender: self)
        } else {
            errorSaveData(from: from)
        }
    }
    
    func deletePersonalInfoData(){
        guard let data = self.viewModel?.deletePersonalInfo(data: personalInfoData ?? Personal_Info()) else { return }
        if data {
            performSegue(withIdentifier: "backToStepVC", sender: self)
        } else {
            errorSaveData(from: "Delete")
        }
    }
    
    @objc func updateEdu(sender: UIBarButtonItem) {
        if personalInfoForm.checkAllFieldValue() {
            saveData(from: "Update")
        } else {
            filledCantBeEmpty()
        }
    }
}
