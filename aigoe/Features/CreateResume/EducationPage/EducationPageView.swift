//
//  EducationPageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol ListEduDelegate: AnyObject{
    func addEduForm(from: String)
    func editEduForm(from: String, edu: Education)
    func selectButtonEdu(eduId: String, isSelected: Bool)
}

class EducationPageView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var emptyStateView: EmptyState!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var eduData = [Education]()
    weak var delegate: ListEduDelegate?
    var eduViewModel = EducationListViewModel()
    
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
        notificationCenterSetup()
        tableView.tableFooterView = UIView()
    }
    
    convenience init(edu: [Education]) {
        self.init()
        
        eduData = edu
        registerTableView()
        notificationCenterSetup()
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
        navigateToEduForm(from: "add")
    }
    
    func navigateToEduForm(from: String, eduData: Education = Education()){
        delegate?.addEduForm(from: from)
    }

    // seting for table view
    func registerTableView(){
        tableView.register(EducationTableCell.nib(), forCellReuseIdentifier: EducationTableCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if eduData.count != 0 {
            emptyStateView.isHidden = true
            return eduData.count
        } else {
            showEmptyState()
            self.tableView.backgroundView = emptyStateView
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EducationTableCell.identifier, for: indexPath) as? EducationTableCell else {
            return UITableViewCell()
        }
        eduData = self.eduViewModel.getEduData()
        let edu = eduData[indexPath.row]
        let eduPeriod = "\(edu.start_date?.string(format: Date.ISO8601Format.MonthYear) ?? "") - \(edu.end_date?.string(format: Date.ISO8601Format.MonthYear) ?? "")"
        
        cell.institutionName.text = edu.institution
        cell.educationTitle.text = edu.title
        cell.educationPeriod.text = eduPeriod
        cell.educationGPA.text = "\(edu.gpa)"
        cell.educationActivities.text = edu.activity
        if edu.is_selected {
            cell.checklistButtonIfSelected()
        } else {
            cell.checklistButtonUnSelected()
        }
        
        cell.editButtonAction = {
            self.delegate?.editEduForm(from: "edit", edu: edu)
        }
        
        cell.checklistButtonAction = {
            if cell.selectionStatus == false{
                cell.selectionStatus = true
                cell.checklistButtonIfSelected()
                self.eduData[indexPath.row].is_selected = true
                //EducationRepository.shared.updateSelectedEduStatus(edu_id: edu.edu_id ?? "", isSelected: true)
                self.delegate?.selectButtonEdu(eduId: edu.edu_id ?? "", isSelected: true)
            } else {
                cell.selectionStatus = false
                cell.checklistButtonUnSelected()
                self.eduData[indexPath.row].is_selected = false
                //EducationRepository.shared.updateSelectedEduStatus(edu_id: edu.edu_id ?? "", isSelected: false)
                self.delegate?.selectButtonEdu(eduId: edu.edu_id ?? "", isSelected: false)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180 // 160 + UIEdgeInsets (+12 bottom)
    }
}

//MARK: Alert
extension EducationPageView {
    func showEmptyState() {
        emptyStateView.isHidden = false
        emptyStateView.emptyStateImage.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        emptyStateView.emptyStateImage.contentMode = .scaleAspectFit
        emptyStateView.emptyStateImage.clipsToBounds = true
        emptyStateView.emptyStateTitle.isHidden = true
        emptyStateView.emptyStateImage.image = UIImage.imgEmptyStateEdu
        emptyStateView.emptyStateDescription.text = "You haven’t filled your educational history. Click the ‘Add’ button to add your educational information."
    }
}

//MARK: Reload Function
extension  EducationPageView {
    func getAndReload(){
        eduData = eduViewModel.getEduData()
        tableView.reloadData()
    }
    
    @objc func eduReload() {
      getAndReload()
    }
    
    func notificationCenterSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(eduReload), name: Notification.Name("eduReload"), object: nil)
    }
}
