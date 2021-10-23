//
//  ExperienceTableCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 23/10/21.
//

import UIKit

class ExperienceTableCell: UITableViewCell {

    @IBOutlet weak var jobCompanyName: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobPeriod: UILabel!
    @IBOutlet weak var jobDesc: UILabel!
    @IBOutlet weak var editExperienceButton: UIButton!
    @IBOutlet weak var selectExperienceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        jobTitle.font = UIFont.italicSystemFont(ofSize: 14.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
