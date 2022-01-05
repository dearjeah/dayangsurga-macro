//
//  PersonalInfoListVC.swift
//  aigoe
//
//  Created by Delvina Janice on 29/12/21.
//

import UIKit

class PersonalInfoList: UIView {
    
    @IBOutlet weak var titleAndButton: HorizontalLabelAndButton!
    @IBOutlet weak var emptyStateView: EmptyState!
    @IBOutlet weak var tableView: UITableView!
    
    var personalData = [User]()
    var resumeContentData = Resume_Content()
    weak var delegate: ListEduDelegate?
    var personalInfoViewModel = PersonalInfoViewModel()
    var withResumeContent = true
    
    func setup(dlgt: ListEduDelegate) {
        self.delegate = dlgt
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        registerTableView()
        setup()
        tableView.tableFooterView = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        registerTableView()
        notificationCenterSetup()
        setup()
        tableView.tableFooterView = UIView()
    }
    
    convenience init(userData: [User], resumeContent: Resume_Content) {
        self.init()
        personalData = userData
        resumeContentData = resumeContent
        registerTableView()
        notificationCenterSetup()
    }
    
    @IBAction func addAction(_ sender: Any) {
        navigateToPersonalInfoForm(from: "add")
    }
    
    func navigateToPersonalInfoForm(from: String, userData: User = User()){
        delegate?.addEduForm(from: from)
    }
}

//MARK: Table View
extension PersonalInfoList: UITableViewDataSource, UITableViewDelegate {
    func registerTableView(){
        tableView.register(PersonalInfoTableCell.nib(), forCellReuseIdentifier: PersonalInfoTableCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Personal Data", personalData)
        if personalData.count != 0 {
            emptyStateView.isHidden = true
        } else {
            showEmptyState()
            self.tableView.backgroundView = emptyStateView
        }
        return personalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInfoTableCell.identifier, for: indexPath) as? PersonalInfoTableCell else {
            return UITableViewCell()
        }
        let personalInfo = personalData[indexPath.row]
        
        
        cell.nameLbl.text = personalInfo.username
        cell.emailLbl.text = personalInfo.email
        cell.phoneNumberLbl.text = personalInfo.phoneNumber
        cell.locLbl.text = personalInfo.location
        cell.summaryLbl.text = personalInfo.summary
        
        if withResumeContent {
            let selectedPersonalInfoId = resumeContentData.personalInfo_id
            let counter = resumeContentData.personalInfo_id?.count ?? 0
            if counter != 0 {
                for i in 0..<counter {
                    if personalData[indexPath.row].personalInfo_id == selectedPersonalInfoId?[i] {
                        /*cell.checklistButtonIfSelected()
                        cell.selectionStatus = true*/
                    }
                }
            } else {
//                cell.checklistButtonUnSelected()
//                cell.selectionStatus = false
            }
        } else {
           /* cell.selectionButton.isHidden = true
            cell.selectionButton.isEnabled = false*/
        }
        
        /*cell.editButtonAction = {
            //self.delegate?.editEduForm(from: "edit", edu: edu)
        }
        
        cell.checklistButtonAction = {
            if cell.selectionStatus == false {
                cell.selectionStatus = true
                cell.checklistButtonIfSelected()
                self.personalData[indexPath.row].is_selected = true
                self.eduViewModel.addSelectedEdu(resumeId: self.resumeContentData.resume_id ?? "", eduId: self.eduData[indexPath.row].edu_id ?? "")
                self.delegate?.selectButtonEdu(eduId: edu.edu_id ?? "", isSelected: true)
            } else {
                cell.selectionStatus = false
                cell.checklistButtonUnSelected()
                self.eduData[indexPath.row].is_selected = false
                self.eduViewModel.removeUnselectedEdu(resumeId: self.resumeContentData.resume_id ?? "", eduId: self.eduData[indexPath.row].edu_id ?? "")
                self.delegate?.selectButtonEdu(eduId: edu.edu_id ?? "", isSelected: false)
            }
        }*/
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180 // 160 + UIEdgeInsets (+12 bottom)
    }
}

//MARK: Alert
extension PersonalInfoList {
    func showEmptyState() {
        emptyStateView.isHidden = false
        emptyStateView.emptyStateImage.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        emptyStateView.emptyStateImage.contentMode = .scaleAspectFit
        emptyStateView.emptyStateImage.clipsToBounds = true
        emptyStateView.emptyStateTitle.isHidden = true
        emptyStateView.emptyStateImage.image = UIImage.imgEmptyStateEdu
        emptyStateView.emptyStateDescription.text = "You haven’t filled your personal information. Click the ‘Add’ button to add your personal information."
    }
}

//MARK: Reload Function
extension  PersonalInfoList {
    func getAndReload(){
        personalData = personalInfoViewModel.getAllUserData()
        tableView.reloadData()
    }
    
    @objc func personalInfoReload() {
        getAndReload()
    }
    
    func notificationCenterSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(personalInfoReload), name: Notification.Name("personalInfoReload"), object: nil)
    }
}

//MARK: Nib
extension  PersonalInfoList {
    func setup(){
        titleAndButton.viewSetup(labelTitle: "Personal Information", buttonTitle: "Add")
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "PersonalInfoList") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

