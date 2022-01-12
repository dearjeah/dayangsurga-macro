//
//  PersonalInfoTableCell.swift
//  aigoe
//
//  Created by Olivia Dwi  Susanti on 26/12/21.
//

import UIKit

class PersonalInfoTableCell: UITableViewCell {
    
    static let identifier = "PersonalInfoTableCell"
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var checklistButn: UIButton!
    @IBOutlet weak var cellBox: DesignableView!
    
    var checklistButtonAction : (() -> ())?
    var editActionButton : (() -> ())?
    var selectionStatus = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.checklistButn.addTarget(self, action: #selector(selectAction(_:)), for: .touchUpInside)
        self.editBtn.addTarget(self, action: #selector(editAction(_:)), for: .touchUpOutside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PersonalInfoTableCell", bundle: nil)
    }
    
    @IBAction func selectAction(_ sender: UIButton) {
        checklistButtonAction?()
    }
    
    @IBAction func editAction(_ sender: Any) {
        editActionButton?()
    }
}
extension PersonalInfoTableCell {
    func checklistButtonIfSelected(){
        selectionStatus = true
        cellBox.layer.borderWidth = 1
        cellBox.layer.cornerRadius = 17
        cellBox.layer.borderColor = UIColor.primaryBlue.cgColor
        checklistButn.setImage(UIImage(named: "icRoundSelectionFilled"), for: .normal)
        nameLbl.textColor = UIColor.primaryBlue
    }
    
    func checklistButtonUnSelected(){
        selectionStatus = false
        checklistButn.setImage(UIImage(named: "icRoundSelectionNoFill"), for: .normal)
        cellBox.layer.borderColor = UIColor.clear.cgColor
        nameLbl.textColor = UIColor.primaryDisable
    }
}
