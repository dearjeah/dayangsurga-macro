//
//  PersonalInfoFormVC.swift
//  aigoe
//
//  Created by Delvina Janice on 05/01/22.
//

import UIKit

class PersonalInfoFormVC: UIViewController {

    @IBOutlet weak var personalInfoForm: PersonalInfoPage!
    override func viewDidLoad() {
        super.viewDidLoad()
        personalInfoForm.delegate = self
    }
}

extension PersonalInfoFormVC: PersonalInfoPageDelegate {
    func isAllTextfieldFilled(was: Bool, data: PersonalInfo) {
        //save
    }
}
