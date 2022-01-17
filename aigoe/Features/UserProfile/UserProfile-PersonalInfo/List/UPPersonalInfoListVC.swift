//
//  UPPersonalInfoListVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPPersonalInfoListVC: MVVMViewController<UPPersonalInfoListViewModel> {
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var personalInfoList: PersonalInfoList!
    
    var personalInfo = [Personal_Info]()
    var emptyStateData = Empty_State()
    var currentUserId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = UPPersonalInfoListViewModel()
        setup()
        aaa()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getInitialData()
        showAddBtn()
        personalInfoList.getAndReload()
    }
    
    @IBAction func addAction(_ sender: Any) {
        performSegue(withIdentifier: "goToUPPIForm", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUPPIForm" {
            let vc = segue.destination as? UPPersonalInfoFormVC
            vc?.dataSource = "Add"
        }
    }
    
    @IBAction func unwindToUPPIForm(_ unwindSegue: UIStoryboardSegue) {
    }
}

// MARK: Initial Setup
extension UPPersonalInfoListVC {
    func setup(){
        self.title = "Personal Information"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.goToPIForm(sender:)))
        addBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func aaa(){
        personalInfoList.delegate = self
        personalInfoList.titleAndButton.isHidden = true
        personalInfoList.withResumeContent = false
    }
    
    @objc func goToPIForm(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToUPPIForm", sender: self)
    }
    
    func showAddBtn() {
        if personalInfo.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
            addBtn.isHidden = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryWhite
            addBtn.isHidden = true
        }
    }
    
}

// MARK: Segue
extension UPPersonalInfoListVC {
    func goToForm(dataSource: String){
        let storyboard = UIStoryboard(name: "UP-PersonalInfo", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToPIForm") as! UPPersonalInfoFormVC
        vc.dataSource = dataSource
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Core Data
extension UPPersonalInfoListVC {
    func getInitialData() {
        personalInfo = self.viewModel?.getAllPersonalInfo() ?? []
    }
}


// MARK: Delegate
extension UPPersonalInfoListVC: PersonalInfoListDelegate{
    func selectButtonPersonal(personalId: String, isSelected: Bool) {
        //
    }
    
    func editUPPersonalInfoForm(from: String, data: Personal_Info) {
        let storyboard = UIStoryboard(name: "UP-PersonalInfo", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToPIForm") as! UPPersonalInfoFormVC
        vc.dataSource = from
        vc.personalInfo = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToPersonalInfoForm(from: String, data: Personal_Info) {
    }
}
