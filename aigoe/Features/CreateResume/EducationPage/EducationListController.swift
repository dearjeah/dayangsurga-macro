//
//  EducationListController.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 01/11/21.
//

import UIKit

class EducationListController: UIViewController {

    @IBOutlet weak var eduListView: EducationPageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        eduListView.setup(dlgt: self)
    }
}

extension EducationListController: ListEduDelegate {
    func goToEduForm() {
        performSegue(withIdentifier: "goToEduForm", sender: self)
    }
}
