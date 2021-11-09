//
//  ExpertListViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class ExpertListViewController: MVVMViewController<ExpertListViewModel> {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerTableView()
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
    }
    
    func registerTableView(){
        tableView.register(ExpertListCell.nib(), forCellReuseIdentifier: ExpertListCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ExpertListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpertListCell.identifier, for: indexPath) as? ExpertListCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = "Utari Hastrarini"
        cell.industryAndExperienceLabel.text = "HR at Startup || 2.5 Years"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
