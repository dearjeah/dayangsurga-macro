//
//  LabelWithTextView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 25/10/21.
//

import UIKit

class LabelWithTextView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextView()
    }
    
    func setupTextView(){
        textView.layer.cornerRadius = 18
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.primaryBlue.cgColor
    }
}
