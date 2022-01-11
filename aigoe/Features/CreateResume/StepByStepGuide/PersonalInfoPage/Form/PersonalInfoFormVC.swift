//
//  PersonalInfoFormVC.swift
//  aigoe
//
//  Created by Delvina Janice on 05/01/22.
//

import UIKit
import AVFAudio

class PersonalInfoFormVC: UIViewController {

    @IBOutlet weak var personalInfoForm: PersonalInfoPage!
    @IBOutlet weak var addDeleteButton: UIButton!
    
    weak var delegate: EduFormDelegate?
    var personalInfoData: Personal_Info? = nil
    var piPlaceholder: PersonalInformation_Placeholder?
    var piSuggestion: PersonalInformation_Suggestion?
    var placeholderLabel : UILabel!
    var dataFrom = ""
    var currentUserId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

extension PersonalInfoFormVC {
    func initialSetup() {
        personalInfoForm.delegate = self
        personalInfoForm.setup()
        buttonStyle()
        
        if personalInfoData != nil {
            personalInfoForm.personalInfoData = personalInfoData
        }
    }
    
    func buttonStyle() {
        if dataFrom == "add" {
            addDeleteButton.dsLongFilledPrimaryButton(withImage: false, text: "Add Personal Information")
        } else {
            addDeleteButton.dsLongUnfilledButton(isDelete: true, text: "Delete Personal Information")
        }
    }
}

extension PersonalInfoFormVC: PersonalInfoPageDelegate {
    func isAllTextfieldFilled(was: Bool, data: PersonalInfo) {
        //save
    }
}
