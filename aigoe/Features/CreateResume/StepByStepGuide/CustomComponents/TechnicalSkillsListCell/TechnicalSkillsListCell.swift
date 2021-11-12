//
//  TechnicalSkillsListCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 26/10/21.
//

import UIKit

class TechnicalSkillsListCell: UITableViewCell {

    var selectionStatus = false
    
    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        if selectionStatus == false{
            selectionStatus = true
            selectionButton.setImage(UIImage(named: "icRoundSelectionFilled"), for: .normal)
            self.layer.borderColor = UIColor.primaryBlue.cgColor
        }else{
            selectionStatus = false
            selectionButton.setImage(UIImage(named: "icRoundSelectionNoFill"), for: .normal)
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 17
        self.layer.borderColor = UIColor.primaryBlue.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}