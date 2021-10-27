//
//  LabelWithStartEndDate.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 25/10/21.
//

import UIKit

class LabelWithStartEndDate: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateButton: UIButton!
    
    @IBAction func startDatePressed(_ sender: UIButton) {
    }
    
    @IBAction func endDatePressed(_ sender: UIButton) {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init(title: String, startDateData: String?, endDateData: String?) {
        self.init()
        titleLabel.text = title
        startDateButton.titleLabel?.text = startDateData ?? "July 2020"
        endDateButton.titleLabel?.text = endDateData ?? "June 2024"
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "LabelWithStartEndDate") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}
