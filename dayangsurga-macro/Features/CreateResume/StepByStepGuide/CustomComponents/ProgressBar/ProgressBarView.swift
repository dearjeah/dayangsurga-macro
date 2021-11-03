//
//  ProgressBarView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class ProgressBarView: UIView {
    
    @IBOutlet weak var personalInformationButton: UIButton!
    @IBOutlet weak var personalInformationButtonImage: UIImageView!
    @IBOutlet weak var educationButton: UIButton!
    @IBOutlet weak var educationButtonImage: UIImageView!
    @IBOutlet weak var workExperienceButton: UIButton!
    @IBOutlet weak var workExperienceButtonImage: UIImageView!
    @IBOutlet weak var technicalSkillButton: UIButton!
    @IBOutlet weak var technicalSkillButtonImage: UIImageView!
    @IBOutlet weak var accomplishmentButtonImage: UIImageView!
    @IBOutlet weak var accomplishmentButton: UIButton!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        //tag: 1-5 1: personal info, 2: education 3: exp, 4: skills, 5: accmomp
        switch sender.tag {
        case 1:
            print("personal info")
        case 2:
            print("edu")
        case 3:
            print("exp")
        case 4:
            print("skills")
        case 5:
            print("accomp")
        default:
            print("nothing")
        }
        
        
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
        guard let view = loadViewFromNib(nibName: "ProgressBarView") else {return}
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
