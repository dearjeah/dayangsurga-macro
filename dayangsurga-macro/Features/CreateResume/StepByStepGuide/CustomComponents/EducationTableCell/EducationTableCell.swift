//
//  EducationTableCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 23/10/21.
//

import UIKit

class EducationTableCell: UITableViewCell {
    var selectionStatus = false
    
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
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 17
//        contentView.layer.borderColor = UIColor.primaryBlue.cgColor
        
    }
    @IBAction func selectEducation(_ sender: Any) {
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
