//
//  ExpertListCell.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 09/11/21.
//

import UIKit

class ExpertListCell: UITableViewCell {
    
    static let identifier = "ExpertListCell"
    
    @IBOutlet weak var expertImage: UIImageView!
    @IBOutlet weak var industryAndExperienceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        expertImage.layer.borderWidth = 0.01
        expertImage.layer.masksToBounds = false
        expertImage.layer.cornerRadius = expertImage.frame.height/2
        expertImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ExpertListCell", bundle: nil)
    }
}
