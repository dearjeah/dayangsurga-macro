//
//  TechnicalSkillsListCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 26/10/21.
//

import UIKit

class TechnicalSkillsListCell: UITableViewCell {

    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 17
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
