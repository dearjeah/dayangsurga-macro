//
//  UPPersonalInfoListVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPPersonalInfoListVC: MVVMViewController<UPPersonalInfoListViewModel> {

    @IBOutlet weak var emptyState: EmptyState!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    var personalInfo = [User]()
    var emptyStateData = Empty_State()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = UPPersonalInfoListViewModel()
        setup()
        registerTableView()
        getInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        tableView.reloadData()
    }
    
    @IBAction func addAction(_ sender: Any) {
        goToForm(dataSource: "Add", totalData: personalInfo.count)
    }
}

// MARK: Initial Setup
extension UPPersonalInfoListVC {
    func setup(){
        self.title = "Personal Information"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.goToPIForm(sender:)))
        addBtn.dsLongFilledPrimaryButton(withImage: false, text: "Add")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func goToPIForm(sender: UIBarButtonItem) {
        goToForm(dataSource: "Add", totalData: personalInfo.count)
    }
    
    func showTopRightCreateResume() {
        if personalInfo.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryWhite
        }
    }
    
    func showEmptyState() {
        emptyState.isHidden = false
        emptyState.emptyStateImage.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        emptyState.emptyStateImage.contentMode = .scaleAspectFill
        emptyState.emptyStateImage.clipsToBounds = true
        emptyState.emptyStateTitle.isHidden = true
        emptyState.emptyStateImage.image = UIImage(data: emptyStateData.image ?? Data())
        emptyState.emptyStateDescription.text = emptyStateData.title
        self.tableView.backgroundView = emptyState
    }
}

// MARK: Segue
extension UPPersonalInfoListVC {
    func goToForm(dataSource: String, totalData: Int){
        let storyboard = UIStoryboard(name: "UP-PersonalInfo", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToPIForm") as! UPPersonalInfoFormVC
        vc.dataSource = dataSource
        vc.totalData = totalData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func passingDataToForm(dataSource: String, personalInfo: User){
        let storyboard = UIStoryboard(name: "UP-PersonalInfo", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToPIForm") as! UPPersonalInfoFormVC
        vc.dataSource = dataSource
        vc.personalInfo = personalInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Core Data
extension UPPersonalInfoListVC {
    func getInitialData() {
        personalInfo = self.viewModel?.getAllPersonalInfo() ?? []
        emptyStateData = self.viewModel?.getEmptyStateId(Id: 5) ?? Empty_State()
        showTopRightCreateResume()
    }
}


// MARK: Table View
extension UPPersonalInfoListVC: UITableViewDelegate, UITableViewDataSource {
    func registerTableView(){
        tableView.register(UINib.init(nibName: "PersonalInfoTableCell", bundle: nil), forCellReuseIdentifier: "PersonalInfoTableCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if personalInfo.isEmpty {
            showEmptyState()
            addBtn.isHidden = false
        } else {
            emptyState.isHidden = true
            addBtn.isHidden = true
        }
        return personalInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalInfoTableCell", for: indexPath) as? PersonalInfoTableCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let personalInfoData = personalInfo[indexPath.row]
        cell.nameLbl.text = personalInfoData.username
        cell.emailLbl.text = personalInfoData.email
        cell.phoneNumberLbl.text = personalInfoData.phoneNumber
        cell.locLbl.text = personalInfoData.location
        cell.summaryLbl.text = personalInfoData.summary
        cell.checklistButn.isHidden = true
        
        cell.editActionButton = {
            self.passingDataToForm(dataSource: "Edit", personalInfo: personalInfoData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
