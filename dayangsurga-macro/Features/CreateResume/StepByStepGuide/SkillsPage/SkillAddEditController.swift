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
        //skillTableView.delegate = self
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "skillEditCell") as! TechnicalSkillsEditCell
        
        return cell
    }
}
