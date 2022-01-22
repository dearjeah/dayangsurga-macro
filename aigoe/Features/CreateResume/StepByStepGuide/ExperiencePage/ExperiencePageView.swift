//
//  ExperiencePageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol ExperienceListDelegate: AnyObject {
    func addExpForm(from: String)
    func editEduForm(from: String, exp: Experience)
    func selectButtonExp(expId: String, isSelected: Bool)
    func editExpUpForm(from: String, exp: Experience)
}

class ExperiencePageView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var expLabel: UILabel!
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var expTableView: UITableView!
    @IBOutlet weak var emptyStateView: EmptyState!
    
    @IBAction func addEditPressed(_ sender: UIButton) {
        experienceDelegate?.addExpForm(from: "add")
    }
    weak var experienceDelegate: ExperienceListDelegate?
    
    var selectedExp = 0
    var stepViewModel = StepByStepGuideViewModel()
    var emptyState: Empty_State?
    var experience = [Experience]()
    var expViewModel = ExperiencePageViewModel()
    var resumeContentData = Resume_Content()
    var withResumeContent = true
    
    func setupExpList(dlgt: ExperienceListDelegate) {
        self.experienceDelegate = dlgt
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        notificationCenterSetup()
        initialSetup()
    }
    
    convenience init(exp: [Experience], resumeContent: Resume_Content) {
        self.init()
        
        notificationCenterSetup()
        experience  = exp
        resumeContentData = resumeContent
        initialSetup()
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "ExperiencePageView") else {return}
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
  
}

//MARK: INITIAL SETUP
extension ExperiencePageView{
    func initialSetup(){
        self.expTableView.register(UINib(nibName: "ExperienceTableCell", bundle: nil), forCellReuseIdentifier: "ExperienceTableCell")
        
        expTableView.delegate = self
        expTableView.dataSource = self
        emptyState = stepViewModel.getEmptyStateId(Id: 2)
        expTableView.reloadData()
    }
    
    func getAndReload(){
        experience = stepViewModel.getExpData() ?? []
        expTableView.reloadData()
    }
    
    @objc func expReload() {
      getAndReload()
    }
    
    func notificationCenterSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(expReload), name: Notification.Name("expReload"), object: nil)
    }
}

//MARK: TABLE VIEW
extension ExperiencePageView{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if experience.count == 0 {
            showEmptyState()
            self.expTableView.backgroundView = emptyStateView
        } else {
            emptyStateView.isHidden = true
        }
        return experience.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expData = experience[indexPath.row]
        selectedExp = indexPath.row
        let exp = experience[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableCell") as! ExperienceTableCell
        cell.jobCompanyName.text = experience[indexPath.row].jobCompanyName
        cell.jobTitle.text = experience[indexPath.row].jobTitle
        if expData.jobStatus == true {
            cell.jobExperience.text = "\(experience[indexPath.row].jobStartDate?.string(format: Date.ISO8601Format.MonthYear) ?? String()) - Present"
        } else {
            cell.jobExperience.text = "\(experience[indexPath.row].jobStartDate?.string(format: Date.ISO8601Format.MonthYear) ?? String()) - \(experience[indexPath.row].jobEndDate?.string(format: Date.ISO8601Format.MonthYear) ?? String())"
        }
        cell.jobDesc.text = experience[indexPath.row].jobDesc
       
        
        if withResumeContent{
            let selectedExpId = resumeContentData.exp_id
            let counter = resumeContentData.exp_id?.count ?? 0
            if counter != 0 {
                for i in 0..<counter {
                    if exp.exp_id == selectedExpId?[i] {
                        cell.checklistButtonIfSelected()
                        cell.selectionStatus = true
                    }
                }
            } else {
                cell.checklistButtonUnSelected()
                cell.selectionStatus = false
            }
        }else{
            cell.selectExperienceButton.isHidden = true
            cell.selectExperienceButton.isEnabled = false
        }
       
        if withResumeContent {
            cell.editButtonAction = {
                self.experienceDelegate?.editEduForm(from: "edit", exp: exp)
            }
        }else{
            cell.editButtonAction = {
                self.experienceDelegate?.editExpUpForm(from: "Edit", exp: exp)
            }
        }
        
        cell.checklistButtonAction = {
            let expId = self.experience[indexPath.row].exp_id ?? ""
            if cell.selectionStatus == false{
                cell.selectionStatus = true
                cell.checklistButtonIfSelected()
                self.experience[indexPath.row].isSelected = true
                self.expViewModel.addSelectedExp(resumeId: self.resumeContentData.resume_id ?? "", expId: self.experience[indexPath.row].exp_id ?? "")
                self.experienceDelegate?.selectButtonExp(expId: expId, isSelected: true)
            }else{
                cell.selectionStatus = false
                cell.checklistButtonUnSelected()
                self.experience[indexPath.row].isSelected = false
                self.expViewModel.removeUnselectedExp(resumeId: self.resumeContentData.resume_id ?? "", expId: self.experience[indexPath.row].exp_id ?? "")
                self.experienceDelegate?.selectButtonExp(expId: expId, isSelected: false)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedExp = indexPath.row
    }
}

//MARK: Reload Data
extension ExperiencePageView: ExperiencePageDelegate, expCellDelegate {
    func passData() -> Experience? {
        let expData = experience[selectedExp]
        return expData
    }
    
    func addExperience() {
       getAndReload()
    }
    
}
