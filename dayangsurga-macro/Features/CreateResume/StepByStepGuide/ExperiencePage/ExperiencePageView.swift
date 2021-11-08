//
//  ExperiencePageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol ExperienceFormDelegate {
    func goToAddEdit(pageName: String)
}

protocol ExperienceListDelegate: AnyObject {
    func goToAddExp()
    func passingExpData(exp: Experience?)
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
    var expDlgt: ExperiencePageDelegate?
    var stepViewModel = StepByStepGuideViewModel()
    var emptyState: Empty_State?
    var experience = [Experience]()
    
    func setup(expDlgt: ExperiencePageDelegate?) {
        self.expDlgt = expDlgt
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        
        expTableView.delegate = self
        expTableView.dataSource = self
        self.expTableView.register(UINib(nibName: "ExperienceTableCell", bundle: nil), forCellReuseIdentifier: "ExperienceTableCell")
        expTableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        
        self.expTableView.register(UINib(nibName: "ExperienceTableCell", bundle: nil), forCellReuseIdentifier: "ExperienceTableCell")
        expTableView.reloadData()
        emptyState = stepViewModel.getEmptyStateId(Id: 2)
        experience = stepViewModel.getExpData() ?? []
        expTableView.reloadData()
    }
    
    convenience init(text: String) {
        self.init()
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

    //MARK: TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if experience.count == 0 {
            let image = UIImage(data: emptyState?.image ?? Data())
            emptyStateView.emptyStateImage.image = image
            emptyStateView.emptyStateDescription.text = emptyState?.title
            self.expTableView.backgroundView = emptyStateView
        } else {
            emptyStateView.isHidden = true
        }
        return experience.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        experience = stepViewModel.getExpData() ?? []
        selectedExp = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableCell") as! ExperienceTableCell
        cell.jobCompanyName.text = experience[indexPath.row].jobCompanyName
        cell.jobTitle.text = experience[indexPath.row].jobTitle
        if experience[indexPath.row].jobStatus == true {
            cell.jobExperience.text = "\(experience[indexPath.row].jobStartDate?.string(format: Date.ISO8601Format.MonthYear) ?? String()) - Present"
        } else {
            cell.jobExperience.text = "\(experience[indexPath.row].jobStartDate?.string(format: Date.ISO8601Format.MonthYear) ?? String()) - \(experience[indexPath.row].jobEndDate?.string(format: Date.ISO8601Format.MonthYear) ?? String())"
        }
        cell.jobDesc.text = experience[indexPath.row].jobDesc
        cell.editButtonAction = { [unowned self] in
            experienceDelegate?.passingExpData(exp: passData())
//            selectedIndex = indexPath.row
//            let experiences = stepViewModel.getExpByIndex(id: selectedIndex)
//            experienceDelegate?.goToEdit()
        }
        cell.checklistButtonAction = { [unowned self] in
            if cell.selectionStatus == false{
                cell.selectionStatus = true
                cell.checklistButtonIfSelected()
            }else{
                cell.selectionStatus = false
                cell.checklistButtonUnSelected()
            }
//            if experience[indexPath.row].isSelected == true {
//                cell.selectionStatus = true
//                cell.checklistButtonIfSelected()
//            }else{
//                cell.selectionStatus = false
//                cell.checklistButtonUnSelected()
//            }
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
        print(indexPath, "=======")

    }
}

extension ExperiencePageView: ExperiencePageDelegate, expCellDelegate {
    func passData() -> Experience? {
        let expData = experience[selectedExp]
        return expData
    }
    
    func addExperience() {
        //update table view
    }
}
