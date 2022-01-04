//
//  UPEducationListVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPEducationListVC: MVVMViewController<UPEducationListViewModel> {

    @IBOutlet weak var listView: EducationPageView!
    @IBOutlet weak var addBtn: UIButton!
    
    var edu = [Education]()
    var eduViewModel = EducationListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = UPEducationListViewModel()
        getInitialData()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getInitialData()
        listView.getAndReload()
        showTopRightAddBtn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUPEduForm" {
            let vc = segue.destination as? UPEducationFormVC
            vc?.dataSource = "Add"
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        performSegue(withIdentifier: "goToUPEduForm", sender: self)
    }
    
    @IBAction func unwindToUPEduList(_ unwindSegue: UIStoryboardSegue) {
    }
}

// MARK: Initial Setup
extension UPEducationListVC {
    func setup(){
        self.title = "Education"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.goToEduForm(sender:)))
        showTopRightAddBtn()
        
        addBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add")
        listView.delegate = self
        listView.eduData = edu
        
        listView.titleLbl.isHidden = true
        listView.addButton.isHidden = true
        listView.withResumeContent = false
    }
    
    @objc func goToEduForm(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToUPEduForm", sender: self)
    }
    
    func showTopRightAddBtn() {
        if edu.isEmpty {
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

// MARK: Delegate
extension UPEducationListVC: ListEduDelegate {
    func addEduForm(from: String) {
    }
    
    func editEduForm(from: String, edu: Education) {
    }
    
    func selectButtonEdu(eduId: String, isSelected: Bool) {
    }
    
    func editUPEduForm(from: String, edu: Education) {
        let storyboard = UIStoryboard(name: "UP-Education", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEducationForm") as! UPEducationFormVC
        vc.dataSource = from
        vc.eduData = edu
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Core Data
extension UPEducationListVC {
    func getInitialData() {
        edu = self.viewModel?.getAllEducation() ?? []
    }
}
