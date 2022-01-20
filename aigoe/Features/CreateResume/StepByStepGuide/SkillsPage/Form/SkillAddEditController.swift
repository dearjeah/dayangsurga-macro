//
//  SkillAddEditController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 31/10/21.
//

import UIKit

class SkillAddEditController: MVVMViewController<SkillsFormViewModel> {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var skillTableView: UITableView!
    @IBOutlet weak var skillSuggest: UILabel!
    
    struct LocalSkills{
        var id: String
        var name: String
    }
    
    var skill: [Skills]? = []
    var localSkill: [LocalSkills] = []
    var skillSuggestion: Skills_Suggest?
    var skillPh: Skills_Placeholder?
    var skillData = 0
    var dataFrom: String = ""
    var stringChecker = ""
    var currentUserId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        setup()
        self.viewModel = SkillsFormViewModel()
        skill = self.viewModel?.getSkillData()
        hideKeyboardWhenTappedAround()
        dataChecker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        skillTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? StepByStepGuideViewController {
            vc.formSource = "skills"
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let a = LocalSkills(id: UUID().uuidString, name: "")
        localSkill.append(a)
        DispatchQueue.main.async {()->Void in
            self.skillTableView.reloadData()
        }
        skillTableView.resignFirstResponder()
    }
    
    @objc func updateSkills(sender: UIBarButtonItem) {
        if dataFrom == "Edit"{
            updateData()
        }else{
            saveData()
        }
        performSegue(withIdentifier: "backToStepVC", sender: self)
    }
    
}

//MARK: Initial Setup
extension SkillAddEditController {
    func setup(){
        self.viewModel = SkillsFormViewModel()
        skill = self.viewModel?.getSkillData()
        skillSuggestion = self.viewModel?.getSkillSuggestion(id: 0)
        skillPh = self.viewModel?.getPlacehoder(id: 0)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateSkills(sender:)))
    }
}

//MARK: Table View
extension SkillAddEditController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return localSkill.count
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell =  skillTableView.dequeueReusableCell(withIdentifier: "skillEditCell") as! TechnicalSkillsEditCell
            cell.delegate = self
            cell.skillTextField.tag = indexPath.row
            skillData = localSkill.count
            if dataFrom == "Edit"{
                cell.skillTextField.text = localSkill[indexPath.row].name
                cell.deleteSkillButton.isHidden = false
            } else {
                if skillData != 0 {
                    cell.skillTextField.text = localSkill[indexPath.row].name
                    cell.deleteSkillButton.isHidden = false
                }else{
                    cell.skillTextField.placeholder = skillPh?.skills_name_ph
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 50
        } else {
            return 40
        }
    }
    
    func registerTableView(){
        skillTableView.dataSource = self
        self.skillTableView.register(UINib(nibName: "TechnicalSkillsEditCell", bundle: nil), forCellReuseIdentifier: "skillEditCell")
        self.skillTableView.register(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "LabelCell")
    }
}

//MARK: Local Data
extension SkillAddEditController {
    func dataChecker() {
        let tmp = skill?.count ?? 0
        if tmp != 0 {
            for i in 0..<tmp {
                let a = LocalSkills(id: skill?[i].skill_id ?? String(), name: skill?[i].skill_name ?? "")
                localSkill.append(a)
            }
        } else {
            let a = LocalSkills(id: UUID().uuidString, name: "")
            localSkill.append(a)
        }
        skillTableView.reloadData()
    }
    
    func checkSkillId(skillId: String) -> Bool{
        let skillCount = localSkill.count
        for i in 0..<skillCount{
            if skillId == localSkill[i].id {
                return true
            }
        }
        return false
    }
    
    func checkSkillCoreData(skillId: String) -> Bool {
        let skillCount = skill?.count ?? 0
        for i in 0..<skillCount{
            if skillId == skill?[i].skill_id {
                return true
            }
        }
        return false
    }
    
    func updateData(){
        skillData = skill?.count ?? 0
        
        if skillData != localSkill.count{
            let skillCount = localSkill.count
            if skillCount < skillData {
                //                let dataCount = skill?.count ?? 0
                for i in 0..<skillData{
                    let skillId = skill?[i].skill_id
                    if !checkSkillId(skillId: skillId ?? "") {
                        guard let getIndex = self.viewModel?.getSkillsById(id: skillId ?? "") else { return }
                        let deleteSkill = self.viewModel?.deleteSkill(skill: getIndex)
                        if deleteSkill == false {
                            failSave()
                            return
                        }
                    }
                }
                
            } else {
                let skillCount = localSkill.count
                let _ = skill?.count ?? 0 - 1
                for i in 0..<skillCount{
                    let skillId = localSkill[i].id
                    let skillName = localSkill[i].name
                    if !checkSkillCoreData(skillId: skillId) {
                        let skill = self.viewModel?.createSkill(userId: currentUserId, skillId: skillId, skillName: skillName , isSelected: true)
                        if skill == false {
                            failSave()
                            return
                        }
                    }
                }
            }
        }else{
            for i in 0..<skillData{
                let skillId = localSkill[i].id
                let skillName = localSkill[i].name
                let skill = self.viewModel?.updateSkill(skillId: skillId, skillName: skillName , isSelected: true)
                if skill == false{
                    failSave()
                    return
                }
            }
        }
    }
}

//MARK: Core Data
extension SkillAddEditController {
    func saveData(){
        skillData = localSkill.count
        for i in 0..<skillData{
            let skillId = localSkill[i].id
            let skillName = localSkill[i].name
            let skill = self.viewModel?.createSkill(skillId: skillId, skillName: skillName , isSelected: true)
            if skill == false{
                failSave()
                return
            }
        }
    }
    
    func deleteData(index: Int){
        skillData = localSkill.count
        self.localSkill.remove(at: index)
        skillTableView.reloadData()
    }
}

//MARK: Alert
extension SkillAddEditController {
    func failSave(){
        showAlert(title: "Failed to save Skill Data", msg: "Please try to save again later.", style: .default, titleAction: "OK")
    }
}

//MARK: Delegate
extension SkillAddEditController: TechnicalSkillEditDelegate {
    func checkIfEdit(index: Int, input: String) {
        for i in 0..<localSkill.count{
            if i == index {
                localSkill[i].name = input
            }
        }
    }
}
