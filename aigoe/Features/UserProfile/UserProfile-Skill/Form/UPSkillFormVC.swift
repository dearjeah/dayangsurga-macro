//
//  UPSkillFormVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPSkillFormVC: MVVMViewController<UPSkillFormViewModel> {
    
    @IBOutlet weak var skillTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    struct LocalSkills{
        var id: String
        var name: String
    }
    
    var userSkills = [Skills]()
    var localSkills = [LocalSkills]()
    var skillSuggestion = Skills_Suggest()
    var skillPh = Skills_Placeholder()
    var localDataCounter = 0
    var isAdd = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = UPSkillFormViewModel()
        hideKeyboardWhenTappedAround()
        initialSetup()
        tableViewSetup()
    }
}

//MARK: Button Action
extension UPSkillFormVC{
    @IBAction func addButton(_ sender: UIButton) {
        let a = LocalSkills(id: UUID().uuidString, name: "")
        localSkills.append(a)
        DispatchQueue.main.async {()->Void in
            self.skillTableView.reloadData()
        }
        skillTableView.resignFirstResponder()
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if isAdd {
            saveAllData()
        }else{
            updateData()
        }
        performSegue(withIdentifier: "backToSkillList", sender: self)
    }
}

//MARK: Table View
extension UPSkillFormVC: UITableViewDataSource {
    func tableViewSetup(){
        skillTableView.dataSource = self
        self.skillTableView.register(UINib(nibName: "TechnicalSkillsEditCell", bundle: nil), forCellReuseIdentifier: "skillEditCell")
        self.skillTableView.register(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "LabelCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return localSkills.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell =  skillTableView.dequeueReusableCell(withIdentifier: "skillEditCell") as! TechnicalSkillsEditCell
            cell.delegate = self
            cell.skillTextField.tag = indexPath.row
            localDataCounter = localSkills.count
            if !isAdd {
                cell.skillTextField.text = localSkills[indexPath.row].name
                cell.deleteSkillButton.isHidden = false
            } else {
                if localDataCounter != 0 {
                    cell.skillTextField.text = localSkills[indexPath.row].name
                    cell.deleteSkillButton.isHidden = false
                }else{
                    cell.skillTextField.placeholder = skillPh.skills_name_ph
                    cell.deleteSkillButton.isHidden = true
                }
            }
            cell.deleteButtonAction = {
                self.deleteData(index: indexPath.row)
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelCell.identifier, for: indexPath) as? LabelCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
}

//MARK: Alert
extension UPSkillFormVC {
    func failSave(){
        showAlert(title: "Failed to save Skill Data", msg: "Please try to save again later.", style: .default, titleAction: "OK")
    }
}

//MARK: Delegate
extension UPSkillFormVC: TechnicalSkillEditDelegate {
    func checkIfEdit(index: Int, input: String) {
        for i in 0..<localSkills.count{
            if i == index {
                localSkills[i].name = input
            }
        }
    }
}

//MARK: Local & Core Data Function
extension UPSkillFormVC {
    func addSkill(skillId: String, skillName: String){
        let skill = self.viewModel?.createSkill(skillId: skillId, skillName: skillName , isSelected: false)
        if skill == false {
            failSave()
            return
        }
    }
    func deleteSkill(skillId: String) {
        guard let getIndex = self.viewModel?.getSkillsById(id: skillId) else { return }
        let deleteSkill = self.viewModel?.deleteSkill(skill: getIndex)
        if deleteSkill == false {
            failSave()
            return
        }
    }
    
    func updateData(){
        let skillData = userSkills.count
        
        if skillData != localSkills.count{
            let skillCount = localSkills.count
            if skillCount < skillData {
                for i in 0..<skillData{
                    let skillId = userSkills[i].skill_id
                    if checkSkillId(skillId: skillId ?? "") == false {
                        deleteSkill(skillId: skillId ?? "")
                    }
                }
            } else {
                let skillCount = localSkills.count
                for i in 0..<skillCount{
                    let skillId = localSkills[i].id
                    let skillName = localSkills[i].name
                    if !checkSkillCoreData(skillId: skillId) {
                       addSkill(skillId: skillId, skillName: skillName)
                    }
                }
            }
        }else{
            for i in 0..<skillData{
                let skillId = localSkills[i].id
                let skillName = localSkills[i].name
                let skill = self.viewModel?.updateSkill(skillId: skillId, skillName: skillName , isSelected: false)
                if skill == false{
                    failSave()
                    return
                }
            }
        }
    }
    
    func saveAllData(){
        localDataCounter = localSkills.count
        for i in 0..<localDataCounter{
            let skillId = localSkills[i].id
            let skillName = localSkills[i].name
            let skill = self.viewModel?.createSkill(skillId: skillId, skillName: skillName , isSelected: true)
            if skill == false{
                failSave()
                return
            }
        }
    }
    
    func deleteData(index: Int){
        localDataCounter = localSkills.count
        self.localSkills.remove(at: index)
        skillTableView.reloadData()
    }
}

//MARK: Checker
extension UPSkillFormVC {
    func dataChecker() {
        let tmp = userSkills.count
        if tmp != 0 {
            for i in 0..<tmp {
                let a = LocalSkills(id: userSkills[i].skill_id ?? String(), name: userSkills[i].skill_name ?? "")
                localSkills.append(a)
            }
        } else {
            let a = LocalSkills(id: UUID().uuidString, name: "")
            localSkills.append(a)
        }
        skillTableView.reloadData()
    }
    
    func checkSkillId(skillId: String) -> Bool{
        let skillCount = localSkills.count
        for i in 0..<skillCount{
            if skillId == localSkills[i].id {
                return true
            }
        }
        return false
    }
    
    func checkSkillCoreData(skillId: String) -> Bool {
        let skillCount = userSkills.count
        for i in 0..<skillCount{
            if skillId == userSkills[i].skill_id {
                return true
            }
        }
        return false
    }
}

//MARK: Initial Setup
extension UPSkillFormVC {
    func initialSetup(){
        skillSetup()
        dataChecker()
        buttonSetup()
        navigationSetup()
    }
    
    func skillSetup(){
        skillSuggestion = self.viewModel?.getSkillSuggestion(id: 0) ?? Skills_Suggest()
        skillPh = self.viewModel?.getPlacehoder(id: 0) ?? Skills_Placeholder()
    }
    func buttonSetup(){
        saveButton.dsLongFilledPrimaryButton(withImage: false, text: "Save")
    }
    
    func navigationSetup(){
        configureNavigationBar(largeTitleColor: .white, backgoundColor:UIColor.primaryBlue, tintColor: UIColor.white, title: "Technical Skills", preferredLargeTitle: false, hideBackButton: false)
    }
}
