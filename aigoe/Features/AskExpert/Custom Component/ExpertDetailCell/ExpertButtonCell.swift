//
//  ExpertButtonCell.swift
//  aigoe
//
//  Created by Olivia Dwi  Susanti on 22/12/21.
//

import UIKit

class ExpertButtonCell: UITableViewCell {

    @IBOutlet weak var whatsappBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        whatsappBtn.dsLongFilledPrimaryButton(withImage: false, text: "  Ask in WhatsApp")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
