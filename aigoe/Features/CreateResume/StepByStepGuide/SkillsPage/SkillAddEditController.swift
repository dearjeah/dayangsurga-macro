//
//  SkillAddEditController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 31/10/21.
//

import UIKit

class SkillAddEditController: MVVMViewController<SkillsFormViewModel>, UITableViewDataSource, TechnicalSkillEditDelegate {
    
    func checkIfEdit(index: Int, input: String) {
//        if let newValue = input.flatMap(String){
//            localSkill = rece
//        }
        for i in 0..<localSkill.count{
            if i == index {
                localSkill[i].name = input
            }
        }
    }
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var skillTableView: UITableView!
    @IBOutlet weak var skillSuggest: UILabel!
    
    
    struct localSkills{
        var id: Int
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
            let skill = self.viewModel?.createSkill(skillId: Int(skillId), skillName: skillName , isSelected: true)
            if skill == false{
                let alert = UIAlertController(title: "Failed to save Skill Data", message: "Please try to save again later.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "oke", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
    }
    
    func checkChange(){
        
    }
    
    func dataChecker() {
        let tmp = skill?.count ?? 0
        if tmp != 0 {
            for i in 0..<tmp {
                let a = localSkills(id: Int(skill?[i].skill_id ?? 0), name: "")
                localSkill.append(a)
            }
        } else {
            let a = localSkills(id: 1001, name: "")
            localSkill.append(a)
        }
    }
    
//    func updateData(){
//        skillData = skill?.count ?? 0
//        for i in 0..<skillData{
//            let skillId = localSkill?[i].skill_id ?? 0
//            let skillName = localSkill?[i].skill_name ?? ""
//            let skill = self.viewModel?.updateSkill(skillId: Int(skillId), skillName: skillName , isSelected: true)
//            if skill == false{
//                failSave()
//                return
//            }
//        }
//        if skillData != localSkill?.count{
//            let skillCount = localSkill?.count ?? 0
//            for i in 0..<skillCount{
//                if skill?[i].skill_id != localSkill?[i].skill_id{
//                    let skillId = localSkill?[i].skill_id ?? 0
//                    let skillName = localSkill?[i].skill_name ?? ""
//                    let skill = self.viewModel?.createSkill(skillId: Int(skillId), skillName: skillName , isSelected: true)
//                    if skill == false{
//                        failSave()
//                        return
//                    }
//                }
//            }
//        }
//    }
    
    func failSave(){
        let alert = UIAlertController(title: "Failed to save Skill Data", message: "Please try to save again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "oke", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let skillTemp = Skills()
        let localSkillCounter =  self.localSkill.count
//        skillTemp.skill_id = Int32(1000+localSkillCounter)
//        skillTemp.skill_name = ""
//        localSkill.append(skillTemp)
        let a = localSkills(id: 1001, name: "")
        localSkill.append(a)
        self.skillTableView.performBatchUpdates({
            self.skillTableView.insertRows(at: [IndexPath(row: localSkillCounter - 1,section: 0)],with: .automatic)
        }, completion: nil)
        self.skillTableView.reloadData()
    }
    
    @objc func updateSkills(sender: UIBarButtonItem) {
        saveData()
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
//        stringChecker = cell.skillTextField.text!
        skillData = localSkill.count
        
        
        if dataFrom == "Edit"{
            for i in 0..<skillData{
                skill = self.viewModel?.getSkillData()
                cell.skillTextField.text = skill?[i].skill_name
            }
        }else{
            skillData = localSkill.count
            for i in 0..<skillData{
                cell.skillTextField.placeholder = skillPh?.skills_name_ph
            }
        }
       
       
        return cell
    }
    
}
