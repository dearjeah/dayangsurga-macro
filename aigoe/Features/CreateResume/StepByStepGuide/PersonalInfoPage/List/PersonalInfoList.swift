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
    func selectButtonPersonal(personalId: String, isSelected: Bool)
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
    var personalIndex: [(index: Int, personalId: String, isSelected: Bool)] = []
    
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
        setup()
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
        var currentSelected = ""
        
        cell.nameLbl.text = personalInfo.fullName
        cell.emailLbl.text = personalInfo.email
        cell.phoneNumberLbl.text = personalInfo.phoneNumber
        cell.locLbl.text = personalInfo.location
        cell.summaryLbl.text = personalInfo.summary
        
        if withResumeContent {
            if !personalIndex.isEmpty {
                if personalIndex[indexPath.row].isSelected == true {
                    cell.checklistButtonIfSelected()
                    currentSelected = personalIndex[indexPath.row].personalId
                } else {
                    cell.checklistButtonUnSelected()
                }
            }
        }else {
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
            if self.personalIndex[indexPath.row].isSelected == false {
                if currentSelected != "" {
                    self.viewModel.deleteSelectedPersonalInfo(resumeId: self.resumeContentData.resume_id ?? "", personalInfoId: currentSelected)
                }
                for i in 0...self.personalIndex.count - 1 {
                    self.personalIndex[i].isSelected = false
                }
                self.personalIndex[indexPath.row].isSelected = true
                currentSelected = self.personalIndex[indexPath.row].personalId
                self.viewModel.addSelectedPersonalInfo(resumeId: self.resumeContentData.resume_id ?? "", personalInfoId: currentSelected)
                cell.checklistButtonIfSelected()
                self.delegate?.selectButtonPersonal(personalId: currentSelected, isSelected: true)
                tableView.reloadData()
            } else {
                self.delegate?.selectButtonPersonal(personalId: currentSelected, isSelected: false)
                //self.viewModel.deleteSelectedPersonalInfo(resumeId: self.resumeContentData.resume_id ?? "", personalInfoId: currentSelected)
                self.personalIndex[indexPath.row].isSelected = false
                currentSelected = ""
                cell.checklistButtonUnSelected()
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
        populateData()
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
        populateData()
    }
    
    func populateData(){
        if !personalData.isEmpty {
            for i in 0...personalData.count - 1 {
                if withResumeContent {
                    if personalData[i].personalInfo_id == resumeContentData.personalInfo_id {
                        personalIndex.append((index: i, personalId: personalData[i].personalInfo_id ?? "", isSelected: true))
                    } else {
                        personalIndex.append((index: i, personalId: personalData[i].personalInfo_id ?? "", isSelected: false))
                    }
                }
            }
        }
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

