//
//  ViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class UserProfileViewController: MVVMViewController<UserProfileListViewModel> {

    @IBOutlet weak var comingSoon: EmptyState!
    @IBOutlet weak var userProfileListTableView: UITableView!
    
    var userProfileData = [UserProfileList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UserProfileListViewModel()
        
        getInitialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationStyle()
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.sizeToFit()
    }
    
   
}

//MARK: Table View
extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableSetup(){
        userProfileListTableView.register(UINib.init(nibName: "UserProfileListCell", bundle: nil), forCellReuseIdentifier: "UserProfileListCell")
        userProfileListTableView.delegate = self
        userProfileListTableView.dataSource = self
        userProfileListTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProfileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileListCell", for:indexPath) as? UserProfileListCell else { return UITableViewCell()}
                
        let data = userProfileData[indexPath.row]
        
        cell.img.image = data.img
        cell.titleLabel.text = data.title
        
        return cell
    }
}

//MARK: Setup
extension UserProfileViewController {
    func getInitialSetup(){
        userProfileData = viewModel?.getUserProfileList() ?? []
        navigationStyle()
        tableSetup()
    }
    
    func navigationStyle(){
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor:UIColor.primaryBlue,
                               tintColor: UIColor.white,
                               title: "Profile",
                               preferredLargeTitle: true,
                               hideBackButton: false )
    }
    
    func setComingSoon() {
        comingSoon.emptyStateImage.image = UIImage.comingSoon
        comingSoon.emptyStateTitle.font = UIFont.boldSystemFont(ofSize: 20.0)
        comingSoon.emptyStateTitle.textColor = UIColor.primaryBlue
        comingSoon.emptyStateTitle.text = "Coming Soon"
        comingSoon.emptyStateDescription.text = "Features are currently in progress"
        comingSoon.emptyStateDescription.font = UIFont.systemFont(ofSize: 17)
        comingSoon.emptyStateDescription.textColor = UIColor.primaryBlue
    }
}
