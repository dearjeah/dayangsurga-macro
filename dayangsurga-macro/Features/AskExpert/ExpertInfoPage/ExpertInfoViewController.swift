//
//  ExpertInfoViewController.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 09/11/21.
//

import UIKit

class ExpertInfoViewController: MVVMViewController<ExpertInfoViewModel> /* ,UITableViewDelegate, UITableViewDataSource*/{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//

    @IBOutlet weak var infoPageImage: UIImageView!
    @IBOutlet weak var infoPageInstructionTable: UITableView!
    @IBOutlet weak var infoPageDismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoPageInstructionTable.register(UINib(nibName: "ExpertInfoCell", bundle: nil), forCellReuseIdentifier: "ExpertInfoCell")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
