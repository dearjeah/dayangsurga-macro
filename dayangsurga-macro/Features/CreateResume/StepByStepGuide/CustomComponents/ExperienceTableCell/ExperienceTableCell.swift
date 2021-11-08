//
//  ExperienceTableCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 25/10/21.
//

import UIKit

protocol expCellDelegate: AnyObject {
    func passData() -> Experience?
}

class ExperienceTableCell: UITableViewCell {
    var selectionStatus = false
    
    @IBOutlet weak var jobCompanyName: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobExperience: UILabel!
    @IBOutlet weak var jobDesc: UILabel!
    @IBOutlet weak var selectExperienceButton: UIButton!
    @IBOutlet weak var shadowView: DesignableView!
    @IBOutlet weak var editExperienceButton: UIButton!
    
    // for button
    var checklistButtonAction : (() -> ())?
    var editButtonAction : (() -> ())?
    var experience = Experience()
    weak var delegate: expCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //jobTitle.font = UIFont.italicSystemFont(ofSize: 14.0)
        
        self.selectExperienceButton.addTarget(self, action: #selector(selectExperienceTapped(_:)), for: .touchUpInside)
        self.editExperienceButton.addTarget(self, action: #selector(editCellTapped(_:)), for: .touchUpInside)
    }
    
    @IBAction func selectExperienceTapped(_ sender: UIButton) {
        checklistButtonAction?()
    }
    
    @IBAction func editCellTapped(_ sender: UIButton) {
        delegate?.passData()
        editButtonAction?()
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
        selectExperienceButton.setImage(UIImage(named: "icRoundSelectionFilled"), for: .normal)
    }
    
    func checklistButtonUnSelected(){
        selectExperienceButton.setImage(UIImage(named: "icRoundSelectionNoFill"), for: .normal)
        shadowView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func teststststtst(){
        if experience.isSelected == true {
            checklistButtonIfSelected()
        }else{
            checklistButtonUnSelected()
        }
    }
//    if selectionStatus == false{
//        selectionStatus = true
//        checklistButtonIfSelected()
//    }else{
//        selectionStatus = false
//        checklistButtonUnSelected()
//    }
}
