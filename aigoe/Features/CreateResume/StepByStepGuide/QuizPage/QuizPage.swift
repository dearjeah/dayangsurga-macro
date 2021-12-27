//
//  QuizPage.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 31/10/21.
//

import UIKit

protocol QuizPageDelegate: AnyObject {
    func quizAnswer(was: Bool)
}

class QuizPage: UIView {
    
    @IBOutlet var baseView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var quizCard: QuizPageView!
    @IBOutlet weak var yesNoSelection: SmallSetButton!
    
    var divisor: CGFloat!
    var delegate: QuizPageDelegate?
    
    func quizPageSetup(dlgt: QuizPageDelegate) {
        self.delegate = dlgt
    }
    
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
        //matikan untuk beberapa waktu hehe
       /* let card = sender.view ?? UIView()
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
                delegate?.quizAnswer(was: false)
            } else if card.center.x > (baseViewWidth - 75) {
                //move off to right side
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + baseViewWidth, y: card.center.y + 75)
                    card.alpha = 0
                }
                delegate?.quizAnswer(was: true)
            }
            resetCard()
        }*/
    }
    
    func resetCard() {
        UIView.animate(withDuration: 1) {
            self.quizCard.center = self.containerView.center
            self.quizCard.transform = .identity
            self.quizCard.alpha = 1
        }
    }
    
    func setupCardView(){
        quizCard.layer.cornerRadius = 8
        quizCard.layer.borderWidth = 2.0
        quizCard.layer.borderColor = UIColor.primaryBlue.cgColor
        yesNoSelection.buttonStyle(from: "quiz")
    }
    
    func loadData(type: Int) -> [String] {
        var header = ""
        var desc = ""
        var cue = ""
        var quiz: Quiz?
        switch type {
        case 1:
            quiz = getQuizId(id: 0)
            header = quiz?.header ?? String()
            desc = quiz?.desc ?? String()
            cue = quiz?.cue ?? String()
        case 2:
            quiz = getQuizId(id: 1)
            header = quiz?.header ?? String()
            desc = quiz?.desc ?? String()
            cue = quiz?.cue ?? String()
        case 3:
            quiz = getQuizId(id: 2)
            header = quiz?.header ?? String()
            desc = quiz?.desc ?? String()
            cue = quiz?.cue ?? String()
        default:
            header = ""
            desc = ""
            cue = ""
        }
        return [header,desc,cue]
    }

    func getQuizId(id: Int) -> Quiz?{
        return QuizRepository.shared.getQuizById(quiz_id: id)
    }
}
