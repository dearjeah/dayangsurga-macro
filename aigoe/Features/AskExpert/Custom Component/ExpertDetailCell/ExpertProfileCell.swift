//
//  ExpertProfileCell.swift
//  aigoe
//
//  Created by Olivia Dwi  Susanti on 22/12/21.
//

import UIKit

class ExpertProfileCell: UITableViewCell {
    
    @IBOutlet weak var expertImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var availibiltyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
