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
    
    var switcherStatus: Bool!
    var getIndexExp = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.viewModel = ExperienceFormViewModel()
        setup()
        expPlaceholder = self.viewModel?.getExpPh()
        expSuggestion = self.viewModel?.getExpSuggestion()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func addExperiencePressed(_ sender: UIButton) {
        expDelegate?.addExperience()
        if experience == nil{
            //add/update to core data
            alertForCheckTF()
            ExperienceRepository.shared.createExperience(exp_id: 0,
                                                         user_id: 0,
                                                         jobTitle: jobTitle.textField.text ?? String(),
                                                         jobDesc: jobSummary.textView.text ?? String(),
                                                         jobCompanyName: companyName.textField.text ?? String(),
                                                         jobStartDate: jobPeriod.startDatePicker.date,
                                                         jobEndtDate: jobPeriod.startDatePicker.date,
                                                         jobStatus: switcherStatus,
                                                         isSelected: true)
            addExpBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add Experience")
            let storyboard = UIStoryboard(name: "XIBTes", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "goToXIBTes") as! XIBTesViewController
            vc.navigationItem.setHidesBackButton(true, animated:true)
            self.navigationController?.pushViewController(vc, animated: true)
        } else { // update and edit
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateExp(sender:)))
            experience =  self.viewModel?.getExpByIndex(id: getIndexExp)
            experience?.jobCompanyName = companyName.textField.text ?? String()
            experience?.jobTitle = jobTitle.textField.text ?? String()
            experience?.jobDesc = jobSummary.textView.text ?? String()
            experience?.jobStatus = jobStatus.switchButton.isOn
            experience?.jobStartDate = jobPeriod.startDatePicker.date
            experience?.jobEndDate = jobPeriod.startDatePicker.date
            addExpBtn.dsLongUnfilledButton(isDelete: true, text: "Delete Experience")
        }
    }
    
    func setup(){
        self.title = "Professional Experience"
        self.viewModel = ExperienceFormViewModel()
        expPlaceholder = self.viewModel?.getExpPh()
        expSuggestion = self.viewModel?.getExpSuggestion()
        companyName.titleLabel.text = "Company Name*"
        companyName.textField.placeholder = expPlaceholder?.companyName_ph
        jobTitle.titleLabel.text = "Job Title*"
        jobTitle.textField.placeholder = expPlaceholder?.jobTitle_ph
        jobStatus.titleLabel.text = "Job Status*"
        jobStatus.switchTitle.text = "Currently Working Here"
        jobPeriod.titleLabel.text = "Job Period*"
        jobSummary.titleLabel.text = "Job Summary*"
        jobSummary.textView.text = nil
        jobSummary.textView.placeholder = expPlaceholder?.jobDesc_ph
        jobSummary.cueLabel.text = expSuggestion?.jobDescSuggest
        addExpBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add Experience")
        // disable end date
        if (jobStatus.switchButton.isOn){
            switcherStatus = true
            jobPeriod.endDatePicker.isEnabled = true
        } else {
            switcherStatus = false
            jobPeriod.endDatePicker.isEnabled = false
        }

//        if (jobStatus.switchButton.isOn){
//            jobPeriod.endDatePicker.isEnabled = false
//        } else {
//            jobPeriod.endDatePicker.isEnabled = false
//        }
//        if jobStatus.switchButton.isOn == false {
//            jobPeriod.endDatePicker.isEnabled = false
//            jobPeriod.endDatePicker.isUserInteractionEnabled = false
//        } else if jobStatus.switchButton.isOn == true {
//            jobPeriod.endDatePicker.isEnabled = true
//        }
    }
    
    @objc func updateExp(sender: UIBarButtonItem) {
        experience = self.viewModel?.getExpByIndex(id: getIndexExp)
        ExperienceRepository.shared.updateExperience(exp_id: getIndexExp,
                                                     user_id: 0,
                                                     newJobTitle: jobTitle.textField.text ?? String(),
                                                     newJobDesc: jobSummary.textView.text ?? String(),
                                                     newJobCompanyName: companyName.textField.text ?? String(),
                                                     newJobStartDate: jobPeriod.startDatePicker.date,
                                                     newJobEndtDate: jobPeriod.startDatePicker.date,
                                                     newJobStatus: switcherStatus,
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
//        experience = self.viewModel?.getExpByIndex(id: getIndex ?? Int())
//        self.viewModel?.deleteExpData(experience: experience.getIndex9)
//        self.viewModel?.deleteResumeData(resume: self.userResume[self.selectedIndex])
    }
}
