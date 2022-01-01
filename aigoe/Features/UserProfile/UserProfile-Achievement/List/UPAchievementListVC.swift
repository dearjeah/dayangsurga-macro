//
//  UPAchievementListVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPAchievementListVC: MVVMViewController<UPAchievementListViewModel> {

  
    @IBOutlet weak var emptyStateView: EmptyState!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addAchievementButton: UIButton!
    
    weak var delegate: AccomplishListDelegate?
    var emptyState = Empty_State()
    var achievement = [Accomplishment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = UPAchievementListViewModel()
        setUp()
        registerTableView()
        getInitData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        tableView.reloadData()
    }
    
    @IBAction func addAction(_sender: Any){
        goToForm(from: "Add")
    }
    
}

//MARK: Initial Setup
extension UPAchievementListVC{
    func setUp(){
    self.title = "Accomplishment"
    let backButton = UIBarButtonItem()
    backButton.title = ""
    self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action:#selector(self.goToAccompForm(sender:)))
        addAchievementButton.dsLongFilledPrimaryButton(withImage: false, text: "Add")
    }
    
    @objc func goToAccompForm(sender: UIBarButtonItem){
    goToForm(from: "Add")
    }
    
    func showAddBarBtn(){
        if achievement.isEmpty{
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
        }else{
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryBlue
        }
    }
    
    func showEmptyState(){
        emptyStateView.isHidden = false
        emptyStateView.emptyStateImage.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        emptyStateView.emptyStateImage.contentMode = .scaleAspectFill
        emptyStateView.emptyStateImage.clipsToBounds = true
        emptyStateView.emptyStateTitle.isHidden = true
        emptyStateView.emptyStateImage.image = UIImage(data: emptyState.image ?? Data())
        emptyStateView.emptyStateDescription.text = emptyState.title
        self.tableView.backgroundView = emptyStateView
    }
}

//MARK: Core Data
extension UPAchievementListVC {
    func getInitData(){
        achievement = self.viewModel?.getAllAchievement() ?? []
        emptyState = self.viewModel?.getEmptyStateId(Id: 4) ?? Empty_State()
        showAddBarBtn()
    }
}

//MARK: Segue
extension UPAchievementListVC {
     func goToForm(from: String) {
        let storyboard = UIStoryboard(name: "UP-Achievement", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToAchieveForm") as! UPAchievementFormVC
        vc.dataFrom = from
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func passDataToForm(dataSource: String, accompData: Accomplishment){
        let storyboard = UIStoryboard(name: "UP-Achievement", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToAccompForm")as! UPAchievementFormVC
        vc.dataFrom = dataSource
        vc.accomplish = accompData
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UPAchievementListVC: UITableViewDelegate, UITableViewDataSource{
   
    
    
    func registerTableView(){
        tableView.register(UINib.init(nibName: "AccomplishmentTableCell", bundle: nil), forCellReuseIdentifier: "AccomplishmentTableCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccomplishmentTableCell", for: indexPath)as? AccomplishmentTableCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let accomplishmentData = achievement[indexPath.row]
        cell.awardName.text = accomplishmentData.title
        cell.awardDate.text = accomplishmentData.given_date?.string(format: Date.ISO8601Format.MonthYear)
        cell.awardIssuer.text = accomplishmentData.issuer
        cell.selectionButton.isEnabled = false
        cell.selectionButton.isHidden = true
        
        cell.editButtonAction = {
            self.delegate?.passingAccomplishData(accomplish: self.achievement[indexPath.row])
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if achievement.isEmpty {
            showEmptyState()
            addAchievementButton.isHidden = false
        }else{
            emptyStateView.isHidden = true
            addAchievementButton.isHidden = true
        }
        return achievement.count
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
