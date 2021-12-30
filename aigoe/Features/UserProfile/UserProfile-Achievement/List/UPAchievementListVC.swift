//
//  UPAchievementListVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPAchievementListVC: MVVMViewController<UPAchievementListViewModel> {

    @IBOutlet weak var accomplishmentList: AccomplishmentPageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func goToAddAccom(from: String) {
        let storyboard = UIStoryboard(name: "AchievementListController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToAchieveForm") as! UPAchievementFormVC
        vc.dataFrom = from
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToEditAccom(from: String, accomp: Accomplishment) {
        let storyboard = UIStoryboard(name: "AchievementListController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToAchieveForm") as! UPAchievementFormVC
        vc.dataFrom = from
        vc.accomplish = accomp
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
