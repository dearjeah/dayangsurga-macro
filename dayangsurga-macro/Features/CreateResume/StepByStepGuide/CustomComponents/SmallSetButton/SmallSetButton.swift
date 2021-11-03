//
//  SmallSetButton.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 25/10/21.
//

import UIKit

class SmallSetButton: UIView {
    
    
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func buttonStyle() {
        rightButton.dsShortFilledPrimaryButton(isDisable: false, text: "Next")
        leftButton.dsShortFilledPrimaryButton(isDisable: false, text: "Previous")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        buttonStyle()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        buttonStyle()
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
    }
    @IBAction func leftButtonPressed(_ sender: Any) {
    }
}
