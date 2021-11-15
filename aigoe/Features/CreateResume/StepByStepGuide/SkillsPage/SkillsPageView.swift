//
//  SkillsPageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol skillListDelegate: AnyObject{
    func goToAddEditList()
    func passSkillsData()
    func passDataFromEdit()
}

class SkillsPageView: UIView, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var skillsTableView: UITableView!
    @IBOutlet weak var emptyStateView: EmptyState!
    
    weak var delegate: skillListDelegate?
    var stepViewModel = StepByStepGuideViewModel()
    var emptyState: Empty_State?
    var skills = [Skills]()
    
    let skillDataCount = 1
    
    @IBAction func addEditPressed(_ sender: UIButton) {
        print("Add edit pressed")
        delegate?.goToAddEditList()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        setup()
        emptyState = stepViewModel.getEmptyStateId(Id: 3)
        skills = stepViewModel.getSkillData() ?? []
        skillsTableView.reloadData()
    }
    
    convenience init(text: String) {
        self.init()
    }
    
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "SkillsPageView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setup() {
        addEditButton.titleLabel?.textColor = UIColor.primaryBlue
        skillsTableView.delegate = self
        skillsTableView.dataSource = self
        self.skillsTableView.register(UINib(nibName: "TechnicalSkillsListCell", bundle: nil), forCellReuseIdentifier: "TechnicalSkillsListCell")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if skills.count == 0 {
            addEditButton.setTitle("Add", for: .normal)
            emptyStateView.emptyStateImage.image = UIImage(data: emptyState?.image ?? Data())
            emptyStateView.emptyStateTitle.text = nil
            emptyStateView.emptyStateDescription.text = emptyState?.title
            self.skillsTableView.backgroundView = emptyStateView
        } else {
            addEditButton.setTitle("Edit", for: .normal)
            emptyStateView.isHidden = true
        }
        return skills.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.passDataFromEdit()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TechnicalSkillsListCell") as! TechnicalSkillsListCell
        skills = stepViewModel.getSkillData() ?? []
//        print(skills[indexPath.row].skill_name)
        cell.skillName.text = skills[indexPath.row].skill_name
        cell.checklistButtonAction = {
//            self.skillListDelegate?.getSelectedIndex(index: indexPath.row)
            if cell.selectionStatus == false{
                cell.selectionStatus = true
                cell.checklistButtonIfSelected()
                self.skills[indexPath.row].is_selected = true
                SkillRepository.shared.updateSelectedSkillStatus(skill_id: indexPath.row, isSelected: true)
            }else{
                cell.selectionStatus = false
                cell.checklistButtonUnSelected()
                self.skills[indexPath.row].is_selected = false
                SkillRepository.shared.updateSelectedSkillStatus(skill_id: indexPath.row, isSelected: false)
            }
        }
        return cell
    }
    
    func getAndReload(){
        skills = stepViewModel.getSkillData() ?? []
        skillsTableView.reloadData()
    }
}
