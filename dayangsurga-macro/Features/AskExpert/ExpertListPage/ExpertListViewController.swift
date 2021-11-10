//
//  ExpertListViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class ExpertListViewController: MVVMViewController<ExpertListViewModel> {

    @IBOutlet weak var tableView: UITableView!
    var expert = [Expert_Profile]()
    var selectedIndexExpert: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerTableView()
        setupViewModel()
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
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(self.infoWasPressed(sender:)))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryWhite
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
    
    @objc func infoWasPressed(sender: UIBarButtonItem) {
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
        cell.industryAndExperienceLabel.text = "\(expert[indexPath.row].title_on_list ?? String()) | \(expert[indexPath.row].experience ?? String())"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
