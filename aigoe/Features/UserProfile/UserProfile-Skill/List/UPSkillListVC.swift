//
//  UPSkillListVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPSkillListVC: MVVMViewController<UPSkillListViewModel> {

    @IBOutlet weak var skillListView: SkillsPageView!
    @IBOutlet weak var addButtonView: UIView!
    @IBOutlet weak var addButton: UIButton!
   
    var userSkills = [Skills]()
    var isAdd = true
    @IBAction func unwindToSkillList( _ seg: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UPSkillListViewModel()

        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialSetup()
        skillListView.getAndReload()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? UPSkillFormVC {
            vc.userSkills = userSkills
            vc.isAdd = isAdd
        }
    }
}

extension UPSkillListVC {
    func initialSetup(){
        getData()
        viewSetup()
        navigationStyle()
        addEditButtonSetup()
    }
    
    func navigationStyle(){
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor:UIColor.primaryBlue,
                               tintColor: UIColor.white,
                               title: "Technical Skills",
                               preferredLargeTitle: false,
                               hideBackButton: false )
        self.tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.editSkill(sender:)))
    }
    
    func viewSetup(){
        skillListView.setupForUserProfile()
        skillListView.delegate = self
        skillListView.skills = userSkills
    }
    
    func getData(){
        userSkills = self.viewModel?.getAllUserSkill() ?? []
    }
}

//MARK: Delegate
extension UPSkillListVC: skillListDelegate{
    func passDataFromEdit(from: String) {
        //
    }
    
    func selectButtonSkill(skillId: String, isSelected: Bool) {
        //
    }
}

//MARK: Helper Func
extension UPSkillListVC {
    func addEditButtonSetup() {
        if userSkills.isEmpty {
            topRightEditButton(will: false)
        } else {
            topRightEditButton(will: true)
        }
    }
    
    func topRightEditButton(will: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = will
        
        if will {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryWhite
        } else {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
        }
        
        addButton.dsLongFilledPrimaryButton(withImage: false, text: "Add")
        addButtonView.isHidden = will
        addButton.isEnabled = !will
    }
}

//MARK: Action Func
extension UPSkillListVC {
    @objc func editSkill(sender: UIBarButtonItem) {
        isAdd = false
        performSegue(withIdentifier: "goToUPSkillForm", sender: UIBarButtonItem.self)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        isAdd = true
        performSegue(withIdentifier: "goToUPSkillForm", sender: UIButton.self)
    }
}
