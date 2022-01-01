//
//  UPAchievementFormVC.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import UIKit

class UPAchievementFormVC: MVVMViewController<UPAchievementFormViewModel>{
    
    @IBOutlet weak var BackgroundView: DesignableButton!
    @IBOutlet weak var CertificateNameView: LabelWithTextField!
    @IBOutlet weak var additionalCertificateLabel: UILabel!
    @IBOutlet weak var givenDateView: LabelWithDate!
    @IBOutlet weak var achievementStatusView: LabelWithSwitch!
 
    @IBOutlet weak var endDateView: LabelWithDate!
    
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
