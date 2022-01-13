//
//  PersonalInfoListVC.swift
//  aigoe
//
//  Created by Delvina Janice on 29/12/21.
//

import UIKit

protocol PersonalInfoListDelegate: AnyObject {
    func goToPersonalInfoForm(from: String, data: Personal_Info)
    func editUPPersonalInfoForm(from: String, data: Personal_Info)
}

class PersonalInfoList: UIView {
    
    @IBOutlet weak var titleAndButton: HorizontalLabelAndButton!
    @IBOutlet weak var emptyStateView: EmptyState!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: PersonalInfoListDelegate?
    var personalData = [Personal_Info]()
    var resumeContentData = Resume_Content()
    var personalInfoViewModel = PersonalInfoViewModel()
    var viewModel = PersonalInfoViewModel()
    var withResumeContent = true
    
    func setup(dlgt: PersonalInfoListDelegate) {
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
    
    convenience init(personalInfoData: [Personal_Info], resumeContent: Resume_Content) {
        self.init()
        personalData = personalInfoData
        resumeContentData = resumeContent
        registerTableView()
        notificationCenterSetup()
    }
}

//MARK: Delegate
extension PersonalInfoList: HorizontalLabelAndButtonDelegate {
    func buttonPressed(title: String) {
        delegate?.goToPersonalInfoForm(from: "add", data: Personal_Info())
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
        
        
        cell.nameLbl.text = personalInfo.fullName
        cell.emailLbl.text = personalInfo.email
        cell.phoneNumberLbl.text = personalInfo.phoneNumber
        cell.locLbl.text = personalInfo.location
        cell.summaryLbl.text = personalInfo.summary
        
        if withResumeContent {
            let selectedPersonalInfoId = resumeContentData.personalInfo_id
            if personalInfo.personalInfo_id == selectedPersonalInfoId {
                cell.checklistButtonIfSelected()
                cell.selectionStatus = true
            } else {
                cell.checklistButtonUnSelected()
                cell.selectionStatus = false
            }
        } else {
            cell.checklistButn.isHidden = true
            cell.checklistButn.isEnabled = false
        }
        
        if withResumeContent {
            cell.editActionButton = {
                self.delegate?.goToPersonalInfoForm(from: "edit", data: personalInfo)
            }
        } else {
            cell.cellBox.layer.borderColor = UIColor.clear.cgColor
            cell.editActionButton = {
                self.delegate?.editUPPersonalInfoForm(from: "Edit", data: personalInfo)
            }
        }
        
        cell.checklistButtonAction = {
            if cell.selectionStatus == false {
                cell.selectionStatus = true
                cell.checklistButtonIfSelected()
                self.viewModel.addSelectedPersonalInfo(resumeId: self.resumeContentData.resume_id ?? "", personalInfoId: personalInfo.personalInfo_id ?? "")
            } else {
                cell.selectionStatus = false
                cell.checklistButtonUnSelected()
                self.viewModel.deleteSelectedPersonalInfo(resumeId: self.resumeContentData.resume_id ?? "", personalInfoId: personalInfo.personalInfo_id ?? "")
            }
        }
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
        personalData = personalInfoViewModel.getAllPersonalInfoData()
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
        titleAndButton.delegate = self
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

