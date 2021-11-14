//
//  EducationPageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol ListEduDelegate: AnyObject{
    func goToEduForm()
}

class EducationPageView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var emptyStateView: EmptyState!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var totalData = 0
    weak var delegate: ListEduDelegate?
    
    func setup(dlgt: ListEduDelegate) {
        self.delegate = dlgt
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        registerTableView()
        tableView.tableFooterView = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        registerTableView()
        tableView.tableFooterView = UIView()
    }
    
    convenience init(text: String) {
        self.init()
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "EducationPageView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func addAction(_ sender: Any) {
        actionButton()
    }
    
    // func protocol
    func actionButton(){
        delegate?.goToEduForm()
    }
    
    // seting for table view
    func registerTableView(){
        tableView.register(EducationTableCell.nib(), forCellReuseIdentifier: EducationTableCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if totalData != 0 {
            emptyStateView.isHidden = true
            return 2
        } else {
            emptyStateView.isHidden = false
            emptyStateView.emptyStateImage.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
            emptyStateView.emptyStateImage.contentMode = .scaleAspectFit
            emptyStateView.emptyStateImage.clipsToBounds = true
            emptyStateView.emptyStateTitle.isHidden = true
            emptyStateView.emptyStateImage.image = UIImage(named: "imgEmptyStateEdu")
            emptyStateView.emptyStateDescription.text = "You haven’t filled your educational history. Click the ‘Add’ button to add your educational information."
            self.tableView.backgroundView = emptyStateView
        }
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EducationTableCell.identifier, for: indexPath) as? EducationTableCell else {
            return UITableViewCell()
        }
        cell.institutionName.text = "Universitas Kami"
        cell.educationTitle.text = "B.A in Finance"
        cell.educationPeriod.text = "August 2020 - Present"
        cell.educationGPA.text = "3.90"
        cell.educationActivities.text = "Delivered 5+ Projects and Programs within agreed budget, time and quality for telecom operators in Indonesia and Singapore."
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180 // 160 + UIEdgeInsets (+12 bottom)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
