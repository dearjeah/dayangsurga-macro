//
//  QuizPageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class QuizPageView: UIView {

    @IBOutlet weak var questionHeader: UILabel!
    @IBOutlet weak var questionDescription: UILabel!
    @IBOutlet weak var answerExample: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = CGColor(red: 25.0, green: 42.0, blue: 85.0, alpha: 100.0)
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 8
    }
}
