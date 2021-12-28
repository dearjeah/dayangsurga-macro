//
//  PersonalInfoTableCell.swift
//  aigoe
//
//  Created by Olivia Dwi  Susanti on 26/12/21.
//

import UIKit

class PersonalInfoTableCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var checklistButn: UIButton!
    
    var editActionButton : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.editBtn.addTarget(self, action: #selector(editAction(_:)), for: .touchUpOutside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    @IBAction func editAction(_ sender: Any) {
        editActionButton?()
    }
}
