//
//  UPAchievementListVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPAchievementListVC:  MVVMViewController<UPAchievementListViewModel> {
 
    @IBOutlet weak var accomplishmentList: AccomplishmentPageView!
    @IBOutlet weak var addAchievementButton: UIButton!
    
    weak var delegate: AccomplishListDelegate?
    var achievement = [Accomplishment]()
    var achievementModel = AccomplishmentPageViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UPAchievementListViewModel()
        getInitialData()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        accomplishmentList.getAndReload()
        getInitialData()
        showAddBtn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUPAccompForm"{
            let vc = segue.destination as? UPAchievementFormVC
            vc?.dataFrom = "Add"
        }
    }
    
    @IBAction func addAction(_ sender: Any){
        performSegue(withIdentifier: "goToUPAccompForm", sender: self)
    }
    
    @IBAction func unwindToUPAccompList(_ unwindSegue: UIStoryboardSegue){
    }

}

//MARK: Initial Setup

extension UPAchievementListVC{
    func setup(){
        self.title = "Accomplishment"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.goToAccompForm(sender:)))
        showAddBtn()
        
        addAchievementButton.dsLongFilledPrimaryButton(withImage: false, text: "Add")
        accomplishmentList.delegate = self
        accomplishmentList.accomplishment = achievement
        accomplishmentList.addButton.isHidden = true
        accomplishmentList.titleLabel.isHidden = true
        accomplishmentList.withResumeContent = false
        
    }
    
    @objc func goToAccompForm(sender: UIBarButtonItem){
        performSegue(withIdentifier: "goToUPAccompForm", sender: self)
    }
    
    func showAddBtn(){
        if achievement.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
            addAchievementButton.isHidden = false
        }else{
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryWhite
            addAchievementButton.isHidden = true
        }
    }
}

//MARK: Delegate
extension UPAchievementListVC: AccomplishListDelegate{
    func selectButtonAccom(accomId: String, isSelected: Bool) {
        
    }
    
    func editAccompForm(from: String, accomp: Accomplishment) {
        
    }
    
    func goToAddAccom() {
        
    }
    
    func editUPAccompForm(from: String, accomp: Accomplishment){
        let storyboard = UIStoryboard(name: "UP-Achievement", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "goToAccompForm")as! UPAchievementFormVC
        vc.dataFrom = from
        vc.accomplish = accomp
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//MARK: Core Data

extension UPAchievementListVC {
    func getInitialData(){
        achievement = self.viewModel?.getAllAchievement() ?? []
    }
}


