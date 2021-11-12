//
//  LabelWithTextView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 25/10/21.
//

import UIKit

class LabelWithTextView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        setupTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        setupTextView()
    }
    
    convenience init(title: String, textViewdPh: String, textViewData: String?) {
        self.init()
        titleLabel.text = title
        textView.placeholder = textViewdPh
        textView.text = textViewData
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "LabelWithTextView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    func setupTextView(){
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.textviewBorder.cgColor
    }
}
