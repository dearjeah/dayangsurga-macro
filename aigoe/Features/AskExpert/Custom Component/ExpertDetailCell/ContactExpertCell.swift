//
//  ContactExpertCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 11/11/21.
//

import Foundation
import UIKit

protocol goToLinkedIn:AnyObject{
    func goToLink()
}

class ContactExpertCell:UITableViewCell{
    @IBOutlet weak var contactLinkedIn: UIButton!
    weak var delegate: goToLinkedIn?
    
    @IBAction func contactPressed(_ sender: UIButton) {
        
    }
    
    func setUpProtocol(dlgt: goToLinkedIn){
        self.delegate = dlgt
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      
    }
}
