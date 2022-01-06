//
//  UPExperienceListVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPExperienceListVC:  MVVMViewController<UPExperienceListViewModel> {

    @IBOutlet weak var experienceListView: ExperiencePageView!
    
    var exp = [Experience]()
    var expViewModel = ExpertListViewModel()
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UPExperienceListViewModel()
        setup()
        getInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getInitialData()
        experienceListView.getAndReload()
        showAddBtn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUPExpForm" {
            let vc = segue.destination as? UPExperiecenFormVC
            vc?.dataFrom = "Add"
        }
    }
    
    @IBAction func addBtnPressed(_ sender: Any){
        performSegue(withIdentifier: "goToUPExpForm", sender: self)
    }
    
    @IBAction func unwindToUPExpList(_ unwindSegue: UIStoryboardSegue){
    }
    
}

//MARK: Initial setup
extension UPExperienceListVC{
    func setup(){
        self.title = "Experience"
        let backButton = UIBarButtonItem()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = backButton
        self.tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.goToExpForm(sender:)))
        showAddBtn()
        addButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Experience")
        experienceListView.experienceDelegate = self
        experienceListView.experience = exp
        experienceListView.addEditButton.isHidden = true
        experienceListView.expLabel.isHidden = true
        experienceListView.withResumeContent = false
        
    }
    
    func showAddBtn(){
        if exp.isEmpty{
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
            addButton.isHidden = false
        }else{
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryWhite
            addButton.isHidden = true
        }
    }
    
    @objc func goToExpForm(sender: UIBarButtonItem){
        performSegue(withIdentifier: "goToUPExpForm", sender: self)
    }
}

//MARK: Core Data
extension UPExperienceListVC{
    func getInitialData(){
        exp = self.viewModel?.getAllExperience() ?? []
    }
}

//MARK: Delegate

extension UPExperienceListVC: ExperienceListDelegate{
    
    func editExpUpForm(from: String, exp: Experience) {
        let storyboard = UIStoryboard(name: "UP-Experience", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToUPExpForm") as! UPExperiecenFormVC
        vc.dataFrom = from
        vc.exp = exp
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func goToAddExp() {
        
    }
    
    func passingExpData(exp: Experience?) {
        
    }
    
    func selectButtonExp(expId: String, isSelected: Bool) {
        
    }
    
}
