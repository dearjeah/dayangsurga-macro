//
//  QuizPage.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 31/10/21.
//

import UIKit

class QuizPage: UIView {
    
    @IBOutlet var baseView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var quizCard: QuizPageView!
    @IBOutlet weak var swipeImages: YesNoSwipeView!
    
    var divisor: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        setupCardView()
        divisor = (containerView.frame.width / 2) / 0.80
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        setupCardView()
        divisor = (containerView.frame.width / 2) / 0.80
    }
    
    convenience init(type: Int) {
        //type 1-3
        self.init()
        let data = loadData(type: type)
        
        quizCard.questionHeader.text = data[0]
        quizCard.questionDescription.text = data[1]
        quizCard.answerExample.text = data[2]
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
    
    @IBAction func panMoved(_ sender: UIPanGestureRecognizer) {
        let card = sender.view ?? UIView()
        //detect how far you move
        let point = sender.translation(in: containerView)
        let xFromCenter = card.center.x - containerView.center.x
        let scale = min(100/abs(xFromCenter), 1)
        
        // width/2 = result/degree in radian = endResult
        //sample: 100/2 = 50/0.61
        card.center = CGPoint(x: containerView.center.x + point.x, y: containerView.center.y + point.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        
        if sender.state == UIPanGestureRecognizer.State.ended {
            let baseViewWidth = self.baseView.frame.width
            if card.center.x < 75 {
                //move off to left side
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x - baseViewWidth, y: card.center.y + 75)
                    card.alpha = 0
                }
                return
            } else if card.center.x > (baseViewWidth - 75) {
                //move off to right side
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + baseViewWidth, y: card.center.y + 75)
                    card.alpha = 0
                }
                return
            }
            resetCard()
        }
    }
    
    func resetCard() {
        UIView.animate(withDuration: 0.2) {
            self.quizCard.center = self.containerView.center
            self.quizCard.transform = .identity
            self.quizCard.alpha = 1
        }
    }
    
    func setupCardView(){
        quizCard.layer.cornerRadius = 8
        quizCard.layer.borderWidth = 2.0
        quizCard.layer.borderColor = UIColor.primaryBlue.cgColor
    }
    
    func loadData(type: Int) -> [String] {
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
        return [header,desc,cue]
    }
    
}
