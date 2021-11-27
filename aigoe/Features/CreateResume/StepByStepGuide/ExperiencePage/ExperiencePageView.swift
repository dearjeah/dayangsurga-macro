//
//  ExperiencePageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol ExperienceListDelegate: AnyObject {
    func goToAddExp()
    func passingExpData(exp: Experience?)
    func selectButtonExp(expId: String, isSelected: Bool)
}

class ExperiencePageView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var expTableView: UITableView!
    @IBOutlet weak var emptyStateView: EmptyState!
    
    @IBAction func addEditPressed(_ sender: UIButton) {
        experienceDelegate?.goToAddExp()
    }
    weak var experienceDelegate: ExperienceListDelegate?
    
    var selectedExp = 0
    var stepViewModel = StepByStepGuideViewModel()
    var emptyState: Empty_State?
    var experience = [Experience]()
    
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
    
    convenience init(exp: [Experience]) {
        self.init()
        
        notificationCenterSetup()
        experience  = exp
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
    
    //MARK: TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if experience.count == 0 {
            emptyState = stepViewModel.getEmptyStateId(Id: 2)
            let image = UIImage(data: emptyState?.image ?? Data())
            emptyStateView.emptyStateImage.image = image
            emptyStateView.emptyStateTitle.isHidden = true
            emptyStateView.emptyStateDescription.text = emptyState?.title
            self.expTableView.backgroundView = emptyStateView
        } else {
            emptyStateView.isHidden = true
        }
        return experience.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //experience = stepViewModel.getExpData() ?? []
        let expData = experience[indexPath.row]
        selectedExp = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableCell") as! ExperienceTableCell
        cell.jobCompanyName.text = experience[indexPath.row].jobCompanyName
        cell.jobTitle.text = experience[indexPath.row].jobTitle
        if expData.jobStatus == true {
            cell.jobExperience.text = "\(experience[indexPath.row].jobStartDate?.string(format: Date.ISO8601Format.MonthYear) ?? String()) - Present"
        } else {
            cell.jobExperience.text = "\(experience[indexPath.row].jobStartDate?.string(format: Date.ISO8601Format.MonthYear) ?? String()) - \(experience[indexPath.row].jobEndDate?.string(format: Date.ISO8601Format.MonthYear) ?? String())"
        }
        cell.jobDesc.text = experience[indexPath.row].jobDesc
        cell.editButtonAction = {
            self.experienceDelegate?.passingExpData(exp: self.experience[indexPath.row])
        }
        
        if expData.isSelected == false{
            cell.checklistButtonUnSelected()
        }else{
            cell.checklistButtonIfSelected()
        }
        
        cell.checklistButtonAction = {
            let expId =  self.experience[indexPath.row].exp_id ?? ""
            if cell.selectionStatus == false{
                cell.selectionStatus = true
                cell.checklistButtonIfSelected()
                expData.isSelected = true
                ExperienceRepository.shared.updateSelectedExpStatus(exp_id: UUID().uuidString, isSelected: true)
            }else{
                cell.selectionStatus = false
                cell.checklistButtonUnSelected()
                expData.isSelected = false
                ExperienceRepository.shared.updateSelectedExpStatus(exp_id: UUID().uuidString, isSelected: false)
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

extension ExperiencePageView: ExperiencePageDelegate, expCellDelegate {
    func passData() -> Experience? {
        let expData = experience[selectedExp]
        return expData
    }
    
    func addExperience() {
       getAndReload()
    }
}
