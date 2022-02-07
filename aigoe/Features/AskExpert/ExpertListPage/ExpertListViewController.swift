//
//  ExpertListViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class ExpertListViewController: MVVMViewController<ExpertListViewModel> {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var comingSoon: EmptyState!
    
    var expert = [Expert_Profile]()
    var selectedIndexExpert: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        //registerTableView()
        setupViewModel()
        navigationStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.sizeToFit()
        self.tabBarController?.tabBar.isHidden = false
        self.tableView.reloadData()
    }
    
    func setupView(){
        self.title = "Ask Expert"
        tableView.isHidden = true
        setupComingSoon()
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(self.infoWasPressed(sender:)))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryWhite
    }
    
    func setupComingSoon() {
        comingSoon.emptyStateImage.image = UIImage.comingSoon
        comingSoon.emptyStateTitle.text = "Coming Soon"
        comingSoon.emptyStateDescription.text = "Features are currently in progress"
    }
    
    func setupViewModel(){
        self.viewModel = ExpertListViewModel()
        expert = self.viewModel?.getExpertList() ?? []
    }
    
    func registerTableView(){
        tableView.register(ExpertListCell.nib(), forCellReuseIdentifier: ExpertListCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func navigationStyle(){
        configureNavigationBar(largeTitleColor: .white, backgoundColor:UIColor.primaryBlue, tintColor: UIColor.white, title: "Ask Expert", preferredLargeTitle: true, hideBackButton: false)
    }
    
    @objc func infoWasPressed(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "ExpertInfoViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ExpertInfoViewController")
        vc.navigationController?.isNavigationBarHidden = false
        vc.navigationController?.isToolbarHidden = false
        vc.navigationItem.title = "Info"
        self.present(vc, animated: true, completion: nil)
    }
}

extension ExpertListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expert.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        expert = self.viewModel?.getExpertList() ?? []
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpertListCell.identifier, for: indexPath) as? ExpertListCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = expert[indexPath.row].expert_name
        cell.expertImage.image = UIImage(data: expert[indexPath.row].expert_image ?? Data())
        cell.industryAndExperienceLabel.text = "\(expert[indexPath.row].title_on_list ?? String()) | \(expert[indexPath.row].experience ?? String())"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexExpert = indexPath.row
        let storyboard = UIStoryboard(name: "ExpertDetailsViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToExpertDetail") as! ExpertDetailViewController
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = true
        vc.index = selectedIndexExpert
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
