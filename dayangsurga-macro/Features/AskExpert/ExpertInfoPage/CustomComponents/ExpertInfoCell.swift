//
//  ExpertInfoCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 09/11/21.
//

import UIKit

class ExpertInfoCell: UITableViewCell {

    @IBOutlet weak var instructionView: UIView!
    @IBOutlet weak var instructionText: UILabel!
    @IBOutlet weak var numberBackground: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
}
