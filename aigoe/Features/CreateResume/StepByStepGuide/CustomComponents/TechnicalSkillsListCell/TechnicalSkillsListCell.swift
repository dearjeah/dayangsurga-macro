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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionButton.addTarget(self, action: #selector(selectButtonPressed(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          let margins = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
          contentView.frame = contentView.frame.inset(by: margins)
    }
    
    func checklistButtonIfSelected(){
        shadowView.layer.borderWidth = 1
        shadowView.layer.cornerRadius = 17
        shadowView.layer.borderColor = UIColor.primaryBlue.cgColor
        skillName.textColor = UIColor.primaryBlue
        selectionButton.setImage(UIImage(named: "icRoundSelectionFilled"), for: .normal)
    }
    
    func checklistButtonUnSelected(){
        selectionButton.setImage(UIImage(named: "icRoundSelectionNoFill"), for: .normal)
        shadowView.layer.borderColor = UIColor.clear.cgColor
        skillName.textColor = UIColor.primaryDisable
    }
}
