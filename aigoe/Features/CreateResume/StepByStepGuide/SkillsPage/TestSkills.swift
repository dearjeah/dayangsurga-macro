//
//  TestSkills.swift
//  aigoe
//
//  Created by Audrey Aurelia Chang on 14/11/21.
//

import UIKit

class TestSkills: MVVMViewController<StepByStepGuideViewModel>, skillListDelegate {
    
    var skill: [Skills]? = []
    
    func passDataFromEdit() {
        let storyboard = UIStoryboard(name: "SkillAddEditController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEditSkills") as! SkillAddEditController
        self.viewModel = StepByStepGuideViewModel()
        skill = self.viewModel?.getSkillData()
        if skill?.count == 0{
            vc.dataFrom = "Add"
        }else{
            vc.dataFrom = "Edit"
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func passSkillsData() {
        
    }
    
    @IBOutlet weak var skillsView: SkillsPageView!
    
    override func viewWillAppear(_ animated: Bool) {
        skillsView.getAndReload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skillsView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func goToAddEditList() {
        let storyboard = UIStoryboard(name: "SkillAddEditController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEditSkills") as! SkillAddEditController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func unwindToSkill( sender: UIStoryboardSegue) {
    }


}
