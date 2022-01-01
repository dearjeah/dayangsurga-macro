//
//  UPAchievementFormVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPAchievementFormVC: MVVMViewController<UPAchievementFormViewModel>{
    
    @IBOutlet weak var accomplishmentForm: AccomplishmentPageView!
    var dataFrom = String()
    var accomplish: Accomplishment? = nil
    var achievementPh: Accomplish_Placeholder?
    var achievementSuggest: Accomplishment_Suggest?
    var achievementId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
