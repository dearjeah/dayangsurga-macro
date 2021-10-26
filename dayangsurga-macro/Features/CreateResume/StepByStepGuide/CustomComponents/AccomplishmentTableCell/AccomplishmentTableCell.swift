//
//  AccomplishmentTableCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 25/10/21.
//

import UIKit

class AccomplishmentTableCell: UITableViewCell {

    @IBOutlet weak var awardName: UILabel!
    @IBOutlet weak var awardDate: UILabel!
    @IBOutlet weak var awardIssuer: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var editAwardButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
