//
//  QuizPage.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 31/10/21.
//

import UIKit

class QuizPage: UIView {
    
    @IBOutlet weak var quizCard: QuizPageView!
    @IBOutlet weak var swipeImages: YesNoSwipeView!
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    func setupCardView(){
        quizCard.layer.cornerRadius = 8
        quizCard.layer.borderWidth = 2.0
        quizCard.layer.borderColor = UIColor.primaryBlue.cgColor
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        setupCardView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        setupCardView()
    }
    
    convenience init(type: Int) {
        //type 1-3
        self.init()
        var header = ""
        var desc = ""
        var cue = ""
        switch type {
        case 1:
            header = "Experience Question"
            desc = "Do you have any professional experience?"
            cue = "Example: Internship, Apprentice Program, etc."
        case 2:
            header = "Skills Question"
            desc = "Do you have any technical skills that related to the role that you want to apply?"
            cue = "Example: Swift Programming, Sketch, Figma, Illustration, Project Management, etc."
        case 3:
            header = "Accomplishment Question"
            desc = "Do you have any accomplishment?"
            cue = "Example: Certification of Project Management, IELTS, Graduate Level Certification in Data Science, etc. "
        default:
            header = ""
            desc = ""
            cue = ""
        }
        
        quizCard.questionHeader.text = header
        quizCard.questionDescription.text = desc
        quizCard.answerExample.text = cue
        
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "QuizPage") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}
