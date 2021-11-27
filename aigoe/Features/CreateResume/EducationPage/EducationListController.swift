//
//  EducationListController.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 01/11/21.
//

import UIKit

class EducationListController: MVVMViewController<EducationListViewModel> {

    @IBOutlet weak var eduListView: EducationPageView!
    
    var eduData = [Education]()
    var selectedEduData = Education()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eduListView.setup(dlgt: self)
    }
}

extension EducationListController: ListEduDelegate {
    func selectButtonEdu(eduId: String, isSelected: Bool) {
        //
    }
    
    func editEduForm(from: String, edu: Education) {
        let storyboard = UIStoryboard(name: "EducationFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEduForm") as! EducationFormController
        vc.dataFrom = from
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addEduForm(from: String) {
        let storyboard = UIStoryboard(name: "EducationFormController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "goToEduForm") as! EducationFormController
        vc.dataFrom = from
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
