//
//  UPAchievementFormVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPAchievementFormVC: MVVMViewController<UPAchievementFormViewModel>{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundView: DesignableButton!
    @IBOutlet weak var certificateNameView: LabelWithTextField!
    @IBOutlet weak var additionalCertificateLabel: UILabel!
    @IBOutlet weak var givenDateView: LabelWithDate!
    @IBOutlet weak var achievementStatusView: LabelWithSwitch!
    @IBOutlet weak var issuerView: LabelWithTextField!
    @IBOutlet weak var addOrDeleteButton: UIButton!
    @IBOutlet weak var endDateView: LabelWithDate!
    
    var dataFrom = String()
    var accomplish: Accomplishment? = nil
    var achievementPh: Accomplish_Placeholder?
    var achievementSuggest: Accomplishment_Suggest?
    var currentUserId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UPAchievementFormViewModel()
        achievementPh = self.viewModel?.getAchievementPh()
        achievementSuggest = self.viewModel?.getAchievementSuggest()
        setUp()
        setupScrollView()
        getInitialData()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func buttonWasPressed(_ sender: Any){
        if !alertForCheckTF() {
            if accomplish == nil{
                guard let data = self.viewModel?.addAchievement(
                    userId: currentUserId, title: certificateNameView.textField.text ?? "",
                    givenDate:  givenDateView.datePicker.date,
                    endDate: endDateView.datePicker.date,
                    status: achievementStatusView.switchButton.isOn,
                    issuer: issuerView.textField.text ?? "",
                    desc: ""
                ) else { return errorSaveData(from: "Save") }
                if data {
                    performSegue(withIdentifier: "backToListVC", sender: self)
                } else {
                    errorSaveData(from: "Save")
                }
            } else { // update and edit
                showAlertForDelete()
            }
        }
    }
}

//MARK: Delegate
extension UPAchievementFormVC: LabelSwitchDelegate{
    func getValueSwitch() {
        if (achievementStatusView.switchButton.isOn){
            endDateView.isDatePickerEnable(was: false)
        }else{
            endDateView.isDatePickerEnable(was: true)
        }
    }
}

//MARK: Initial Setup

extension UPAchievementFormVC{
    func setUp(){
        self.title = "Accomplishment"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.viewModel = UPAchievementFormViewModel()
        self.tabBarController?.tabBar.isHidden = true
        achievementPh = self.viewModel?.getAchievementPh()
        achievementSuggest = self.viewModel?.getAchievementSuggest()
        certificateNameView.titleLabel.text = "Certificate/Award Name*"
        additionalCertificateLabel.text = achievementSuggest?.title
        givenDateView.dateTitle.text = "Issued Date*"
        achievementStatusView.switchTitle.text = "Certification/Award Status"
        endDateView.dateTitle.text = "Expiration Date"
        achievementStatusView.titleLabel.text = "Currently Valid"
        achievementStatusView.delegate = self
        endDateView.datePicker.maximumDate = Date()
        issuerView.titleLabel.text = "Issuer*"
        getValueSwitch()
        if dataFrom == "Edit"{
            if accomplish == nil {
            certificateNameView.textField.placeholder = achievementPh?.title_ph
            issuerView.textField.placeholder = achievementPh?.given_date_ph
                addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Accomplishment")
            }else{
                certificateNameView.textField.text = accomplish?.title
                issuerView.textField.text = accomplish?.issuer
                givenDateView.datePicker.date = accomplish?.given_date ?? Date()
                achievementStatusView.switchButton.isOn = ((accomplish?.status) == true)
                endDateView.datePicker.date = accomplish?.end_date ?? Date()
                addOrDeleteButton.dsLongUnfilledButton(isDelete: true, text: "Delete Accomplishment")
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateAccomplish(sender:)))
            }
        }else{
            certificateNameView.textField.placeholder = achievementPh?.title_ph
            issuerView.textField.placeholder = achievementPh?.given_date_ph
            addOrDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Accomplishment")
        }
    }
        
    func setupScrollView(){
        if UIDevice.current.modelName == "iPhone10,4" {
            scrollView.isScrollEnabled = true
        } else if UIDevice.current.modelName == "iPhone12,1" {
            scrollView.isScrollEnabled = false
        } else if UIDevice.current.modelName == "iPhone13,2" {
            scrollView.isScrollEnabled = false
        }
    }
    
}

//MARK: Alert
extension UPAchievementFormVC{
    func errorSaveData(from: String){
        showAlert(title: "Unable to \(from) Data", msg: "Your data is not saved. Please try again later", style: .default, titleAction: "OK")
    }
    
    func alertForCheckTF() -> Bool{
        if((certificateNameView.textField.text?.isEmpty) != false || (issuerView.textField.text?.isEmpty) != false){
            showAlert(title: "Field Can't Be Empty", msg: "You must fill in every mandatory fields in this form.", style: .default, titleAction: "OK")
         return true
        } else {
            return false
        }
    }
    
    func showAlertForDelete(){
        showAlertDelete(title: "Delete Data?", msg: "You will not be able to recover it.", completionBlock: {action in self.deleteAchivementData()})
    }
}

//MARK: Core Data
extension UPAchievementFormVC{
    func getInitialData(){
        achievementPh = self.viewModel?.getAchievementPh()
        achievementSuggest = self.viewModel?.getAchievementSuggest()
    }
    
    func addOrDeleteAccomp(){
        if !alertForCheckTF(){
            if dataFrom == "Add"{
                guard let data = self.viewModel?.addAchievement(userId: currentUserId, title: certificateNameView.textField.text ?? "", givenDate: givenDateView.datePicker.date, endDate: endDateView.datePicker.date, status: achievementStatusView.switchButton.isOn, issuer: issuerView.textField.text ?? "", desc: "") else {return errorSaveData(from: "Save")}
                if data{
                    performSegue(withIdentifier: "backToListVC", sender: self)
                }else{
                    return errorSaveData(from: "Save")
                }
            }else{
                showAlertForDelete()
            }
        }
    }
    
    func deleteAchivementData(){
        guard let data = self.viewModel?.deleteAchievementData(dataAchievement: accomplish)
        else{ return }
        if data {
            self.navigationController?.popViewController(animated: false)
        }else{
            errorSaveData(from: "Delete")
        }
    }
    
    @objc func updateAccomplish(sender: UIBarButtonItem){
        if !alertForCheckTF() {
            guard let achivementId = accomplish?.accomplishment_id else {return}
            guard let data = self.viewModel?.updateAchievement(achievementId: achivementId, title: certificateNameView.textField.text ?? "", givenDate: givenDateView.datePicker.date, endDate: endDateView.datePicker.date, status: achievementStatusView.switchButton.isOn, issuer: issuerView.textField.text ?? "", desc: "") else {
                return errorSaveData(from: "Update") }
            if data{
                performSegue(withIdentifier: "backToListVC", sender: self)
            }else{
                errorSaveData(from: "")
            }
        }
    }
}

