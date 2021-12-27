//
//  LabelWithTextField.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 25/10/21.
//

import UIKit

protocol LabelWithTextFieldDelegate: AnyObject {
    func isTextfieldFilled(was: Bool)
}

class LabelWithTextField: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: LabelWithTextFieldDelegate?
    
    func setup(dlgt: LabelWithTextFieldDelegate) {
        self.delegate = dlgt
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        textField.delegate = self
        setupStyle()
    }
    
    convenience init(title: String, textFieldPh: String, textFieldData: String?) {
        self.init()
        titleLabel.text = title
        textField.placeholder = textFieldPh
        textField.text = textFieldData
        textField.delegate = self
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "LabelWithTextField") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}
extension LabelWithTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 4 {
            delegate?.isTextfieldFilled(was: true)
        } else {
            delegate?.isTextfieldFilled(was: false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    func setupStyle() {
        textField.tintColor = .black
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor =  UIColor.textviewBorder.cgColor
    }
}
