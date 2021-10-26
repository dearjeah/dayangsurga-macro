//
//  SmallSetButton.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 25/10/21.
//

import UIKit

class SmallSetButton: UIView {
    
    
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rightButton.dsShortFilledPrimaryButton(text: "Next")
        leftButton.dsShortFilledPrimaryButton(text: "Next")
    }
    @IBAction func rightButtonPressed(_ sender: Any) {
    }
    @IBAction func leftButtonPressed(_ sender: Any) {
    }
}
