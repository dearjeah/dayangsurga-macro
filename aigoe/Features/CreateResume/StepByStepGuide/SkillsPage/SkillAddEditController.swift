//
//  SkillAddEditController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 31/10/21.
//

import UIKit


class SkillAddEditController: MVVMViewController<SkillsFormViewModel>, UITableViewDataSource {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var skillTableView: UITableView!
    @IBOutlet weak var skillSuggest: UILabel!
    
    var skill: [Skills]? = []
    var skillSuggestion: Skills_Suggest?
    var skillPh: Skills_Placeholder?
    var test: [Int] = []
    var skillName: [String] = []
    var skillData = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        skillTableView.dataSource = self
        self.viewModel = SkillsFormViewModel()
        skill = self.viewModel?.getSkillData()
        skillSuggestion = self.viewModel?.getSkillSuggestion(id: 0)
        skillPh = self.viewModel?.getPlacehoder(id: 0)
        skillSuggest.text = skillSuggestion?.skills_suggest
        self.skillTableView.register(UINib(nibName: "TechnicalSkillsEditCell", bundle: nil), forCellReuseIdentifier: "skillEditCell")
        dataChecker()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateExp(sender:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        skillTableView.reloadData()
    }
    
    func dataChecker(){
        if skill?.count == 0 {
            self.test.append(1)
        }else{
            let skillData = skill?.count ?? 0
            for i in 0...skillData{
                self.test.append(i)
            }
        }
    }
    
    func saveData(){
        skillData = test.count
        for i in 0..<skillData{
            let skill = self.viewModel?.createSkill(skillId: i, skillName: skillName[i] , isSelected: true)
            if skill == false{
                let alert = UIAlertController(title: "Failed to save Skill Data", message: "Please try to save again later.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "oke", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        self.test.append(1)
        self.skillTableView.performBatchUpdates({
                self.skillTableView.insertRows(at: [IndexPath(row: self.test.count - 1,
                                                         section: 0)],
                                          with: .automatic)
            }, completion: nil)
        self.skillTableView.reloadData()
    }
    
    @objc func updateExp(sender: UIBarButtonItem) {
        saveData()
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  skillTableView.dequeueReusableCell(withIdentifier: "skillEditCell") as! TechnicalSkillsEditCell
        cell.skillTextField.placeholder = skillPh?.skills_name_ph
        skillName.append(cell.skillTextField.text ?? "")
        return cell
    }
    
}
