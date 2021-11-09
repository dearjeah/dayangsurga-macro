//
//  ExperienceFormController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 28/10/21.
//

import UIKit

protocol ExperiencePageDelegate {
    func addExperience()
}

class ExperienceFormController: MVVMViewController<ExperienceFormViewModel> {
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var companyName: LabelWithTextField!
    @IBOutlet weak var jobTitle: LabelWithTextField!
    @IBOutlet weak var jobStatus: LabelWithSwitch!
    @IBOutlet weak var jobPeriod: LabelWithStartEndDate!
    @IBOutlet weak var jobSummary: LabelWithTextView!
    @IBOutlet weak var addExpBtn: UIButton!
    
    var expDelegate: ExperiencePageDelegate?
    var experience: Experience? = nil
    var expPlaceholder: Experience_Placeholder?
    var expSuggestion: Experience_Suggestion?
    var placeholderLabel : UILabel!
    var switcherStatus: Bool!
    var getIndexExp = Int()
    var dataFrom = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.viewModel = ExperienceFormViewModel()
        setup()
        expPlaceholder = self.viewModel?.getExpPh()
        expSuggestion = self.viewModel?.getExpSuggestion()
        hideKeyboardWhenTappedAround()
    }
    
//    @IBAction func unwindToXIB(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
//    }
    
    @IBAction func addExperiencePressed(_ sender: UIButton) {
        expDelegate?.addExperience()
        if experience == nil{
            //add/update to core data
            alertForCheckTF()
            ExperienceRepository.shared.createExperience(exp_id: 4,
                                                         user_id: 0,
                                                         jobTitle: jobTitle.textField.text ?? String(),
                                                         jobDesc: jobSummary.textView.text ?? String(),
                                                         jobCompanyName: companyName.textField.text ?? String(),
                                                         jobStartDate: jobPeriod.startDatePicker.date,
                                                         jobEndtDate: jobPeriod.endDatePicker.date,
                                                         jobStatus: jobStatus.switchButton.isOn,
                                                         isSelected: true)
            addExpBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add Experience")
            let storyboard = UIStoryboard(name: "XIBTes", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "goToXIBTes") as! XIBTesViewController
            vc.navigationItem.setHidesBackButton(true, animated:true)
            self.navigationController?.pushViewController(vc, animated: true)
        } else { // update and edit
            showAlertForDelete()
//            performSegue(withIdentifier: "backToXIB", sender: self)
        }
    }
    
    func setup(){
        self.title = "Professional Experience"
        self.viewModel = ExperienceFormViewModel()
        expPlaceholder = self.viewModel?.getExpPh()
        expSuggestion = self.viewModel?.getExpSuggestion()
        companyName.titleLabel.text = "Company Name*"
        jobTitle.titleLabel.text = "Job Title*"
        jobStatus.titleLabel.text = "Job Status*"
        jobStatus.switchTitle.text = "Currently Working Here"
        jobStatus.delegate = self
        jobPeriod.titleLabel.text = "Job Period*"
        jobSummary.titleLabel.text = "Job Summary*"
        jobSummary.cueLabel.text = expSuggestion?.jobDescSuggest
        jobSummary.textView.delegate = self

        if dataFrom == "edit" {
//            experience =  self.viewModel?.getExpByIndex(id: getIndexExp)
            if experience == nil {
                companyName.textField.placeholder = expPlaceholder?.companyName_ph
                jobTitle.textField.placeholder = expPlaceholder?.jobTitle_ph
                jobSummary.textView.text = expPlaceholder?.jobDesc_ph
                jobSummary.textView.textColor = .lightGray
                addExpBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add Experience")
            } else {
                companyName.textField.text = experience?.jobCompanyName
                jobTitle.textField.text = experience?.jobTitle
                jobSummary.textView.text = experience?.jobDesc
                jobStatus.switchButton.isOn = ((experience?.jobStatus) == true)
                jobPeriod.startDatePicker.date = experience?.jobStartDate ?? Date()
                jobPeriod.endDatePicker.date = experience?.jobEndDate ?? Date()
                addExpBtn.dsLongUnfilledButton(isDelete: true, text: "Delete Experience")
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateExp(sender:)))
            }
        } else {
            companyName.textField.placeholder = expPlaceholder?.companyName_ph
            jobTitle.textField.placeholder = expPlaceholder?.jobTitle_ph
            jobSummary.textView.text = nil
            jobSummary.textView.placeholder = expPlaceholder?.jobDesc_ph
            addExpBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add Experience")
        }
    }
    
    @objc func updateExp(sender: UIBarButtonItem) {
        ExperienceRepository.shared.updateExperience(exp_id: 4,
                                                     user_id: 0,
                                                     newJobTitle: jobTitle.textField.text ?? String(),
                                                     newJobDesc: jobSummary.textView.text ?? String(),
                                                     newJobCompanyName: companyName.textField.text ?? String(),
                                                     newJobStartDate: jobPeriod.startDatePicker.date,
                                                     newJobEndtDate: jobPeriod.endDatePicker.date,
                                                     newJobStatus: jobStatus.switchButton.isOn,
                                                     newIsSelected: true)
        let storyboard = UIStoryboard(name: "XIBTes", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToXIBTes") as! XIBTesViewController
        vc.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func alertForCheckTF(){
        if ((companyName.textField.text?.isEmpty) != false) || ((jobTitle.textField.text?.isEmpty) != false) || ((jobSummary.textView.text?.isEmpty) != false){
            let alert = UIAlertController(title: "isi dungg text field nyaa", message: "masih ada yg kosong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "oke", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertForDelete(){
        let alert = UIAlertController(title: "Delete Data?", message: "You will not be able to recover it.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in self.deleteExpData()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    // for delete and reload
    func deleteExpData(){
        self.viewModel?.deleteExpData(dataExperience: experience)
        self.navigationController?.popViewController(animated: false)
    }
}

extension ExperienceFormController: LabelSwitchDelegate {
    func getValueSwitch() {
        if (jobStatus.switchButton.isOn){
            jobStatus.userDefaults.set(true, forKey: jobStatus.on_off_key)
            jobPeriod.endDatePicker.isEnabled = true
        } else {
            jobStatus.userDefaults.set(false, forKey: jobStatus.on_off_key)
            jobPeriod.endDatePicker.isEnabled = false
        }
    }
}

extension ExperienceFormController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView){
        expPlaceholder = self.viewModel?.getExpPh()
            if (jobSummary.textView.text.count  + 1 == expPlaceholder?.jobDesc_ph?.count){
                jobSummary.textView.text = ""
            }
        jobSummary.textView.textColor = .black
    }
}
