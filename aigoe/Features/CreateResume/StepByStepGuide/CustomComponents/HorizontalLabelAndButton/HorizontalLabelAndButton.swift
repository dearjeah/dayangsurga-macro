//
//  HorizontalLabelAndButton.swift
//  aigoe
//
//  Created by Delvina Janice on 05/01/22.
//

import UIKit

protocol HorizontalLabelAndButtonDelegate: AnyObject {
    func buttonPressed(title: String)
}

class HorizontalLabelAndButton: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    weak var delegate: HorizontalLabelAndButtonDelegate?
    
    func setup(dlgt: HorizontalLabelAndButtonDelegate) {
        delegate.self = dlgt
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
}
//MARK: Button Action
extension  HorizontalLabelAndButton {
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.buttonPressed(title: button.titleLabel?.text ?? "Add")
    }
}

//MARK: XIB Setup & Initial Setup
extension  HorizontalLabelAndButton {
    func viewSetup(labelTitle: String, buttonTitle: String){
        button.setTitle(buttonTitle, for: .normal)
        button.mediumTextButton(color: UIColor.primaryBlue)
        titleLabel.sectionTitle(title: labelTitle)
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "HorizontalLabelAndButton") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
