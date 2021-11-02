//
//  ExperienceTableCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 25/10/21.
//

import UIKit

class ExperienceTableCell: UITableViewCell {
    var selectionStatus = false
    
    @IBOutlet weak var jobCompanyName: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobExperience: UILabel!
    @IBOutlet weak var jobDesc: UILabel!
    @IBOutlet weak var selectExperienceButton: UIButton!
    @IBOutlet weak var shadowView: DesignableView!
    @IBOutlet weak var editExperienceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //jobTitle.font = UIFont.italicSystemFont(ofSize: 14.0)
        shadowView.layer.borderWidth = 1

    }

    @IBAction func selectExperience(_ sender: Any) {
        if selectionStatus == false{
            selectionStatus = true
            selectExperienceButton.setImage(UIImage(named: "icRoundSelectionFilled"), for: .normal)
            shadowView.layer.borderColor = UIColor.primaryBlue.cgColor
        }else{
            selectionStatus = false
            selectExperienceButton.setImage(UIImage(named: "icRoundSelectionNoFill"), for: .normal)
            shadowView.layer.borderColor = UIColor.clear.cgColor
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
          contentView.frame = contentView.frame.inset(by: margins)
    }
    
}
