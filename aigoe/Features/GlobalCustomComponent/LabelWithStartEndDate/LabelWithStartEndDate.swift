//
//  LabelWithStartEndDate.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 25/10/21.
//

import UIKit

class LabelWithStartEndDate: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBAction func startDateWasPress(_ sender: Any) {
    }
    @IBAction func endDateWasPress(_ sender: Any) {
    }
    @IBOutlet weak var endDateDisableView: DesignableView!
    @IBOutlet weak var endDateDisableTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        endDateDisableTitle.text = endDatePicker.date.string(format: Date.ISO8601Format.MonthDateYear)
        isEndDatePickerEnable(was: true)
    }
    
    convenience init(title: String, startDateData: String?, endDateData: String?) {
        self.init()
        titleLabel.text = title
        endDateDisableTitle.text = endDatePicker.date.string(format: Date.ISO8601Format.MonthDateYear)
        isEndDatePickerEnable(was: true)
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
    
    func isEndDatePickerEnable(was: Bool){
        if was {
            endDatePicker.isEnabled = was
            endDatePicker.isUserInteractionEnabled = was
            endDateDisableView.isHidden = was
            endDateDisableTitle.text = endDatePicker.date.string(format: Date.ISO8601Format.MonthDateYear)
        } else {
            endDatePicker.isEnabled = was
            endDatePicker.isUserInteractionEnabled = was
            endDateDisableView.isHidden = was
            endDateDisableTitle.text = endDatePicker.date.string(format: Date.ISO8601Format.MonthDateYear)
        }
    }
    
}
