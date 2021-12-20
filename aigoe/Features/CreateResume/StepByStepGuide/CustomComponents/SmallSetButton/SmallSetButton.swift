//
//  SmallSetButton.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 25/10/21.
//

import UIKit

protocol SmallSetButtonDelegate: AnyObject {
    func didTapNext()
    func didTapGenerate()
    func didTapLeftButton()
    func didTapRightButton()
}

class SmallSetButton: UIView {

    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    weak var delegate: SmallSetButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(dlgt: SmallSetButtonDelegate) {
        self.delegate = dlgt
    }
    
    func buttonStyle(from: String) {
        if from == "quiz" {
            setButtonTitle(right: "Yes", left: "No")
        } else {
            setButtonTitle(right: "Next", left: "Previous")
        }
    }
    
    func setButtonTitle(right: String, left: String) {
        rightButton.setTitle(right, for: .normal)
        leftButton.setTitle(left, for: .normal)
        rightButton.dsShortUnfilledButton(isDelete: false, isDisable: false, text: right)
        leftButton.dsShortUnfilledButton(isDelete: false, isDisable: false, text: left)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        //buttonStyle(from: )
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "SmallSetButton") else {return}
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
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        delegate?.didTapRightButton()
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        delegate?.didTapLeftButton()
    }
}
