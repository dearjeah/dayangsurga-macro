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
    func editUPEduForm(from: String, edu: Education)
}

class EducationPageView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var emptyStateView: EmptyState!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var eduData = [Education]()
    var resumeContentData = Resume_Content()
    weak var delegate: ListEduDelegate?
    var eduViewModel = EducationListViewModel()
    var withResumeContent = true
    
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
    
    convenience init(edu: [Education], resumeContent: Resume_Content) {
        self.init()
        eduData = edu
        resumeContentData = resumeContent
        registerTableView()
        notificationCenterSetup()
    }
    
    @IBAction func addAction(_ sender: Any) {
        navigateToEduForm(from: "add")
    }
    
    func navigateToEduForm(from: String, eduData: Education = Education()){
        delegate?.addEduForm(from: from)
    }
}

//MARK: Table View
extension EducationPageView {
    func registerTableView(){
        tableView.register(EducationTableCell.nib(), forCellReuseIdentifier: EducationTableCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if eduData.count != 0 {
            emptyStateView.isHidden = true
        } else {
            showEmptyState()
            self.tableView.backgroundView = emptyStateView
        }
        return eduData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EducationTableCell.identifier, for: indexPath) as? EducationTableCell else {
            return UITableViewCell()
        }
        let edu = eduData[indexPath.row]
        let eduPeriod = "\(edu.start_date?.string(format: Date.ISO8601Format.MonthYear) ?? "") - \(edu.end_date?.string(format: Date.ISO8601Format.MonthYear) ?? "")"
        
        cell.institutionName.text = edu.institution
        cell.educationTitle.text = edu.title
        cell.educationPeriod.text = eduPeriod
        cell.educationGPA.text = "\(edu.gpa)"
        cell.educationActivities.text = edu.activity
        
        if withResumeContent {
            let selectedEduId = resumeContentData.edu_id
            let counter = resumeContentData.edu_id?.count ?? 0
            if counter != 0 {
                for i in 0..<counter {
                    if edu.edu_id == selectedEduId?[i] {
                        cell.checklistButtonIfSelected()
                        cell.selectionStatus = true
                    }
                }
            } else {
                cell.checklistButtonUnSelected()
                cell.selectionStatus = false
            }
        } else {
            cell.selectionButton.isHidden = true
            cell.selectionButton.isEnabled = false
        }
        
        if withResumeContent {
            cell.editButtonAction = {
                self.delegate?.editEduForm(from: "edit", edu: edu)
            }
        } else {
            cell.shadowView.layer.borderColor = UIColor.clear.cgColor
            cell.editButtonAction = {
                self.delegate?.editUPEduForm(from: "Edit", edu: edu)
            }
        }
        
        cell.checklistButtonAction = {
            if cell.selectionStatus == false {
                cell.selectionStatus = true
                cell.checklistButtonIfSelected()
                self.eduData[indexPath.row].is_selected = true
                self.eduViewModel.addSelectedEdu(resumeId: self.resumeContentData.resume_id ?? "", eduId: self.eduData[indexPath.row].edu_id ?? "")
                self.delegate?.selectButtonEdu(eduId: edu.edu_id ?? "", isSelected: true)
            } else {
                cell.selectionStatus = false
                cell.checklistButtonUnSelected()
                self.eduData[indexPath.row].is_selected = false
                self.eduViewModel.removeUnselectedEdu(resumeId: self.resumeContentData.resume_id ?? "", eduId: self.eduData[indexPath.row].edu_id ?? "")
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

//MARK: Nib
extension  EducationPageView {
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
}
