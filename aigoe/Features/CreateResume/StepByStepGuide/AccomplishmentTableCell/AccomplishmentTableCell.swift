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
    @IBOutlet weak var shadowView: DesignableButton!
    static let identifier = "AccomplishmentTableCell"
    var selectionStatus = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.layer.borderColor = UIColor.primaryBlue.cgColor
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    @IBAction func selectAccomplishment(_ sender: UIButton) {
        if selectionStatus == false{
            selectionStatus = true
            selectionButton.setImage(UIImage(named: "icRoundSelectionFilled"), for: .normal)
            shadowView.layer.borderWidth = 1
            shadowView.layer.borderColor = UIColor.primaryBlue.cgColor
        }else{
            selectionStatus = false
            selectionButton.setImage(UIImage(named: "icRoundSelectionNoFill"), for: .normal)
            shadowView.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @IBAction func editAccomplishment(_ sender: UIButton) {
    }
    
    func checklistButtonIfSelected(){
        shadowView.layer.borderWidth = 1
        shadowView.layer.cornerRadius = 17
        shadowView.layer.borderColor = UIColor.primaryBlue.cgColor
        selectionButton.setImage(UIImage(named: "icRoundSelectionFilled"), for: .normal)
    }
    
    func checklistButtonUnSelected(){
        selectionButton.setImage(UIImage(named: "icRoundSelectionNoFill"), for: .normal)
        shadowView.layer.borderColor = UIColor.clear.cgColor
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AccomplishmentTableCell", bundle: nil)
    }
}
