//
//  LabelWithSwitch.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 25/10/21.
//

import UIKit

class LabelWithSwitch: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchTitle: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    @IBAction func switchPressed(_ sender: UISwitch) {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init(title: String, switchText: String, switchValue: Bool?) {
        self.init()
        titleLabel.text = title
        switchTitle.text = switchText
        switchButton.isOn = switchValue ?? false
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "LabelWithSwitch") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
