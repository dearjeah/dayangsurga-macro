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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 8
        self.layer.borderColor = CGColor(red: 25, green: 42, blue: 85, alpha: 100)
        deleteSkillButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
