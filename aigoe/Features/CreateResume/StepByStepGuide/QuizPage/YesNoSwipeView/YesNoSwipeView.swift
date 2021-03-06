//
//  YesNoSwipeView.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 25/10/21.
//

import UIKit

class YesNoSwipeView: UIView {

    @IBOutlet weak var noSwipeImage: UIImageView!
    @IBOutlet weak var yesSwipeImage: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
//    func setupQuizCard(){
//        self.layer.borderColor = UIColor.primaryBlue.cgColor
//        self.layer.borderWidth = 2.0
//        self.layer.cornerRadius = 8
//    }
//
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "YesNoSwipeView") else {return}
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    convenience init() {
        self.init()
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
