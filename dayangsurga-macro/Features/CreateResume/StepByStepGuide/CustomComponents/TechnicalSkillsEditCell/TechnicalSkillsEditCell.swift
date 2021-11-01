//
//  TechnicalSkillsEditCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 26/10/21.
//

import UIKit

class TechnicalSkillsEditCell: UITableViewCell {

    @IBOutlet weak var skillTextField: UITextField!
    @IBOutlet weak var deleteSkillButton: UIButton!
    
    @IBAction func deletePressed(_ sender: UIButton) {
        print("OLIP ROBOT")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.layer.borderWidth = 1
//        self.layer.cornerRadius = 17
//        self.layer.borderColor = UIColor.primaryBlue.cgColor
        //deleteSkillButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
