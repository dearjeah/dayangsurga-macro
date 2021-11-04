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
    
    convenience init(header: String) {
        self.init()
        
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
