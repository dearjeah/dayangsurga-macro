//
//  SkillAddEditController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 31/10/21.
//

import UIKit

class SkillAddEditController: MVVMViewController<SkillsFormViewModel>, UITableViewDataSource, TechnicalSkillEditDelegate {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var skillTableView: UITableView!
    @IBOutlet weak var skillSuggest: UILabel!
    
    struct localSkills{
        var id: String
        var name: String
    }
    
    var skill: [Skills]? = []
    var localSkill: [localSkills] = []
    var skillSuggestion: Skills_Suggest?
    var skillPh: Skills_Placeholder?
    var test: [Int] = []
    var skillData = 0
    var dataFrom: String = ""
    var stringChecker = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skillTableView.dataSource = self
        self.viewModel = SkillsFormViewModel()
        skill = self.viewModel?.getSkillData()
        skillSuggestion = self.viewModel?.getSkillSuggestion(id: 0)
        skillPh = self.viewModel?.getPlacehoder(id: 0)
        skillSuggest.text = skillSuggestion?.skills_suggest
        self.skillTableView.register(UINib(nibName: "TechnicalSkillsEditCell", bundle: nil), forCellReuseIdentifier: "skillEditCell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateSkills(sender:)))
        hideKeyboardWhenTappedAround()
        dataChecker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        skillTableView.reloadData()
    }
    
    func saveData(){
        skillData = localSkill.count
        for i in 0..<skillData{
            let skillId = localSkill[i].id
            let skillName = localSkill[i].name
            print(skillName)
            let skill = self.viewModel?.createSkill(skillId: skillId, skillName: skillName , isSelected: true)
            if skill == false{
                let alert = UIAlertController(title: "Failed to save Skill Data", message: "Please try to save again later.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "oke", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
    }
    
    func checkIfEdit(index: Int, input: String) {
        for i in 0..<localSkill.count{
            if i == index {
                localSkill[i].name = input
            }
        }
    }
    
    func deleteData(index: Int){
        skillData = localSkill.count
        let skillId = localSkill[index].id
//        print(skillId)
        guard let getIndex = self.viewModel?.getSkillsById(id: skillId) else { return }
        self.viewModel?.deleteSkill(skill: getIndex)
        self.localSkill.remove(at: index)
        skillTableView.reloadData()
    }
    
    func dataChecker() {
        let tmp = skill?.count ?? 0
        if tmp != 0 {
            for i in 0..<tmp {
                let a = localSkills(id: skill?[i].skill_id ?? String(), name: skill?[i].skill_name ?? "")
                localSkill.append(a)
            }
        } else {
            let a = localSkills(id: UUID().uuidString, name: "")
            localSkill.append(a)
        }
        skillTableView.reloadData()
    }
    
    func updateData(){
        skillData = skill?.count ?? 0
        
        if skillData != localSkill.count{
            let skillCount = localSkill.count
            let dataCount = skill?.count ?? 0 - 1
            for i in 0..<skillCount{
                for j in 0..<dataCount{
                    if skill?[j].skill_id ?? String() != localSkill[i].id {
                        let skillId = localSkill[i].id
                        let skillName = localSkill[i].name
                        let skill = self.viewModel?.createSkill(skillId: skillId, skillName: skillName , isSelected: true)
                        if skill == false{
                            failSave()
                            return
                        }
                    } else {
                        let skillId = localSkill[i].id
                        let skillName = localSkill[i].name
                        let skill = self.viewModel?.updateSkill(skillId: skillId, skillName: skillName , isSelected: true)
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
    
    func failSave(){
        let alert = UIAlertController(title: "Failed to save Skill Data", message: "Please try to save again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "oke", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let a = localSkills(id: UUID().uuidString, name: "")
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
        performSegue(withIdentifier: "unwindToSkill", sender: self)
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localSkill.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  skillTableView.dequeueReusableCell(withIdentifier: "skillEditCell") as! TechnicalSkillsEditCell
        cell.delegate = self
        cell.skillTextField.tag = indexPath.row
        skillData = localSkill.count
        if dataFrom == "Edit"{
            for i in 0..<skillData{
                cell.skillTextField.text = localSkill[indexPath.row].name
                cell.deleteSkillButton.isHidden = false
            }
        }else{
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
//            self.skillTableView.reloadData()
        }
       
        return cell
    }
    
}
