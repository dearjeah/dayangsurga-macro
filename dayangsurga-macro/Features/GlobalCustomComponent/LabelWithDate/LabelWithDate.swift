//
//  LabelWithDate.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 26/10/21.
//

import UIKit

class LabelWithDate: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func datePickerWasPressed(_ sender: Any) {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init(title: String, dateText: String, dateData: String?) {
        self.init()
        titleLabel.text = title
        dateTitle.text = dateText
//        dateButton.titleLabel?.text = dateData ?? "July 2020"
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "LabelWithDate") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
