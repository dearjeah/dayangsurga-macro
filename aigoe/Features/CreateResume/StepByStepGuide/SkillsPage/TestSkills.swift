//
//  TestSkills.swift
//  aigoe
//
//  Created by Audrey Aurelia Chang on 14/11/21.
//

import UIKit

class TestSkills: MVVMViewController<StepByStepGuideViewModel>, skillListDelegate {
    func passSkillsData() {
        
    }
    
 
   
    @IBOutlet weak var skillsView: SkillsPageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skillsView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func goToAddEditList() {
        print("olip ganteng")
        let storyboard = UIStoryboard(name: "SkillAddEditController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEditSkills") as! SkillAddEditController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func unwindToSkill( sender: UIStoryboardSegue) {
    }
    
//    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, sender: Any?) -> Bool {
//        return action == #selector(self.unwind(_:))
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
