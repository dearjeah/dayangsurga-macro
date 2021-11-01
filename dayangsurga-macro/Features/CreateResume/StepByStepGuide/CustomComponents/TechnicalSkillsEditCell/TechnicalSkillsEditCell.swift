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
        //deleteSkillButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }
    
}
