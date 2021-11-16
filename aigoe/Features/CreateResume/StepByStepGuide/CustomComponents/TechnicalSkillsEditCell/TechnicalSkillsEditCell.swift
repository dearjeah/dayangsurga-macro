//
//  TechnicalSkillsEditCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 26/10/21.
//

import UIKit

protocol TechnicalSkillEditDelegate: AnyObject{
    func checkIfEdit(index: Int, input: String)
    
}

class TechnicalSkillsEditCell: UITableViewCell, UITextFieldDelegate {
    weak var delegate: TechnicalSkillEditDelegate?
    var textfieldAction : (() -> ())?
    var deleteButtonAction : (() -> ())?
    
    @IBOutlet weak var skillTextField: UITextField!
    @IBOutlet weak var deleteSkillButton: UIButton!

    @IBAction func deletePressed(_ sender: UIButton) {
        deleteButtonAction?()
    }
    
    func setUp(dlgt: TechnicalSkillEditDelegate){
        self.delegate = dlgt
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.checkIfEdit(index: textField.tag, input: skillTextField.text ?? "")
        deleteSkillButton.isHidden = false
        print("Olip capek", textField.tag)
        print("Olip lelah sama delegate")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //deleteSkillButton.isHidden = true
        skillTextField.delegate = self
        self.deleteSkillButton.addTarget(self, action: #selector(deletePressed(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }
    
}
