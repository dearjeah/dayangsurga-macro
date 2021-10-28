//
//  BigButtonWithImage.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 26/10/21.
//

import UIKit

protocol ResumeCellDelegate {
    func didTapButton()
}

class BigButtonWithImage: UIView {

    @IBOutlet weak var bigButton: UIButton!
    @IBAction func bigButtonPressed(_ sender: UIButton) {
        tapButton()
    }
    
    var delegate: ResumeCellDelegate?
    func tapButton() {
        delegate?.didTapButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init() {
        self.init()
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "BigButtonWithImage") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
