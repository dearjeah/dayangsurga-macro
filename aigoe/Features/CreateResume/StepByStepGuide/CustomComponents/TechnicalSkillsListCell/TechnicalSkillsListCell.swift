//
//  TechnicalSkillsListCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 26/10/21.
//

import UIKit

class TechnicalSkillsListCell: UITableViewCell {

    var selectionStatus = false
    var checklistButtonAction : (() -> ())?
    
    @IBOutlet weak var shadowView: DesignableButton!
    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        checklistButtonAction?()
//        if selectionStatus == false{
//            selectionStatus = true
//            selectionButton.setImage(UIImage(named: "icRoundSelectionFilled"), for: .normal)
//            self.layer.borderColor = UIColor.primaryBlue.cgColor
//        }else{
//            selectionStatus = false
//            selectionButton.setImage(UIImage(named: "icRoundSelectionNoFill"), for: .normal)
//            self.layer.borderColor = UIColor.clear.cgColor
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.layer.borderWidth = 1
//        self.layer.cornerRadius = 17
//        self.layer.borderColor = UIColor.primaryBlue.cgColor
        self.selectionButton.addTarget(self, action: #selector(selectButtonPressed(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
          contentView.frame = contentView.frame.inset(by: margins)
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
}
