//
//  LabelCell.swift
//  aigoe
//
//  Created by Olivia Dwi  Susanti on 29/11/21.
//

import UIKit

class LabelCell: UITableViewCell {
    
    static let identifier = "LabelCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "LabelCell", bundle: nil)
    }
    
}
