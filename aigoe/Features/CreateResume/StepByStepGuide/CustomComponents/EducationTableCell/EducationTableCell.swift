//
//  EducationTableCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 23/10/21.
//

import UIKit

class EducationTableCell: UITableViewCell {
    var selectionStatus = false
    static let identifier = "EducationTableCell"
    @IBOutlet weak var institutionName: UILabel!
    @IBOutlet weak var educationTitle: UILabel!
    @IBOutlet weak var educationPeriod: UILabel!
    @IBOutlet weak var educationGPA: UILabel!
    @IBOutlet weak var educationActivities: UILabel!
    @IBOutlet weak var shadowView: DesignableButton!
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var editEducationButton: UIButton!
    
    var checklistButtonAction : (() -> ())?
    var editButtonAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shadowView.layer.borderWidth = 1
        shadowView.layer.cornerRadius = 17
        selectionButton.setImage(UIImage(named: "icRoundSelectionFilled"), for: .normal)
//        contentView.layer.borderColor = UIColor.primaryBlue.cgColor
        
    }
    @IBAction func selectEducation(_ sender: Any) {
        if selectionStatus == false {
            selectionStatus = true
            selectionButton.setImage(UIImage.icRoundSelectionFilled, for: .normal)
            shadowView.layer.borderColor = UIColor.primaryBlue.cgColor
        } else {
            selectionStatus = false
            selectionButton.setImage(UIImage.icRoundSelectionNoFill, for: .normal)
            shadowView.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "EducationTableCell", bundle: nil)
    }
    
    func checklistButtonIfSelected(){
        shadowView.layer.borderWidth = 1
        shadowView.layer.cornerRadius = 17
        shadowView.layer.borderColor = UIColor.primaryBlue.cgColor
        selectionButton.setImage(UIImage.icRoundSelectionFilled, for: .normal)
    }
    
    func checklistButtonUnSelected(){
        selectionButton.setImage(UIImage.icRoundSelectionNoFill, for: .normal)
        shadowView.layer.borderColor = UIColor.clear.cgColor
    }
    
}
