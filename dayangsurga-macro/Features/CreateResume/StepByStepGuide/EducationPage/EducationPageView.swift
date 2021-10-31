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
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var totalData = 0
    weak var delegate: ListEduDelegate?
    
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
    
    convenience init() {
        self.init()
        registerTableView()
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
            return 2
        } else {
            let height = self.frame.height
            let width = self.frame.width
//            let positionX = superview?.bounds.midX ?? 0
//            let positionY = superview?.bounds.midY ?? 0
            
            let emptyStateView = EmptyState(frame: CGRect(x: width, y: height, width: width, height: height))
            print("x axes= \(self.bounds.midX)")
            print("y axes= \(self.bounds.midY)")
//            emptyStateView.frame.origin = emptyStateView.frame.origin
            emptyStateView.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
            emptyStateView.center = emptyStateView.convert(emptyStateView.center, from: emptyStateView)
            emptyStateView.emptyStateImage.image = UIImage.imgEmptyStateEdu
            emptyStateView.emptyStateDescription.text = "You haven’t filled your educational history. Click the ‘Add’ button to add your educational information."
            self.tableView.backgroundView = emptyStateView
        }
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EducationTableCell.identifier, for: indexPath) as? EducationTableCell else {
            return UITableViewCell()
        }
//        cell.content.layer.backgroundColor = UIColor.clear.cgColor
//        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.institutionName.text = "Universitas Kami"
        cell.educationTitle.text = "B.A in Finance"
        cell.educationPeriod.text = "August 2020 - Present"
        cell.educationGPA.text = "3.90"
        cell.educationActivities.text = "Delivered 5+ Projects and Programs within agreed budget, time and quality for telecom operators in Indonesia and Singapore."
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180 // 160 + UIEdgeInsets (+20 bottom)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
