//
//  HomepageController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class HomepageController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapBarMultipe(_ sender: Any) {
        
        showSelectionAlertWithCompletion(title: "HAPUS DATA?", msg: "BAKAR ?", confirmMsg: "BAKAR", cancelMsg: "PLS NO") { bakar in
            if bakar {
                CoreDataManager.sharedManager.resetData()
            }
        }
    }
}
