//
//  ContactExpertCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 11/11/21.
//

import Foundation
import UIKit

class ContactExpertCell:UITableViewCell{
    @IBOutlet weak var contactLinkedIn: UIButton!
    
    @IBAction func contactPressed(_ sender: UIButton) {
        print("Contact LinkedIn Expert Pressed")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }
}
