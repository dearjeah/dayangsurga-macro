//
//  TestAccomplishController.swift
//  aigoe
//
//  Created by Olivia Dwi  Susanti on 12/11/21.
//

import UIKit

class TestAccomplishController: MVVMViewController<StepByStepGuideViewModel> {
    
    @IBOutlet weak var accomplishView: AccomplishmentPageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accomplishView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        accomplishView.getAndReload()
    }

}

extension TestAccomplishController: AccomplishListDelegate {
    func selectButtonAccom(accomId: String, isSelected: Bool) {
        //
    }
    
    func passingAccomplishData(accomplish: Accomplishment?) {
        let storyboard = UIStoryboard(name: "AccomplishFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToAccomForm") as! AccomplishFormController
        vc.accomplish = accomplish
        vc.dataFrom = "edit"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToAddAccom() {
        let storyboard = UIStoryboard(name: "AccomplishFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToAccomForm") as! AccomplishFormController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
