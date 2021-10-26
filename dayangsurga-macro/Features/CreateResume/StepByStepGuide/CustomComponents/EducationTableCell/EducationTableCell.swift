//
//  EducationTableCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 23/10/21.
//

import UIKit

class EducationTableCell: UITableViewCell {

    @IBOutlet weak var institutionName: UILabel!
    @IBOutlet weak var educationTitle: UILabel!
    @IBOutlet weak var educationPeriod: UILabel!
    @IBOutlet weak var educationGPA: UILabel!
    @IBOutlet weak var educationActivities: UILabel!
    
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var editEducationButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
