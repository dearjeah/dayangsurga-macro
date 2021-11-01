//
//  SkillAddEditController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 31/10/21.
//

import UIKit

class SkillAddEditController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var skillTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skillTableView.dataSource = self
//        skillTableView.delegate = self
        self.skillTableView.register(UINib(nibName: "TechnicalSkillsEditCell", bundle: nil), forCellReuseIdentifier: "skillEditCell")
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
    }
    
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  skillTableView.dequeueReusableCell(withIdentifier: "skillEditCell") as! TechnicalSkillsEditCell

        return cell
    }
}
