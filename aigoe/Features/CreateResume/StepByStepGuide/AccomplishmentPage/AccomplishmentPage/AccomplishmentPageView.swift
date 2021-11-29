//
//  AccomplishmentPageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol AccomplishListDelegate: AnyObject {
    func goToAddAccom()
    func passingAccomplishData(accomplish: Accomplishment?)
    func selectButtonAccom(accomId: String, isSelected: Bool)
    
}

class AccomplishmentPageView: UIView {

    @IBOutlet weak var emptyStateView: EmptyState!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    weak var delegate: AccomplishListDelegate?
    var stepViewModel = StepByStepGuideViewModel()
    var emptyState = Empty_State()
    var accomplishment = [Accomplishment]()
    
    func setup(dlgt: AccomplishListDelegate) {
        self.delegate = dlgt
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        
        notificationCenterSetup()
        registerTableView()
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        notificationCenterSetup()
        registerTableView()
        tableView.autoresizingMask = UIView.AutoresizingMask()
        emptyState = stepViewModel.getEmptyStateId(Id: 4) ?? emptyState
        accomplishment = stepViewModel.getAccomplishData() ?? accomplishment
        tableView.reloadData()
    }
    
    convenience init(accom: [Accomplishment]) {
        self.init()
        
        notificationCenterSetup()
        accomplishment = accom
    }

    @IBAction func addAction(_ sender: Any) {
        delegate?.goToAddAccom()
    }
    
    func getAndReload(){
        accomplishment = stepViewModel.getAccomplishData() ?? []
        tableView.reloadData()
    }
    
    @objc func accompReload() {
      getAndReload()
    }
}

//MARK: Table View
extension AccomplishmentPageView:  UITableViewDelegate, UITableViewDataSource {
    // setup table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accompData  = accomplishment[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccomplishmentTableCell.identifier, for: indexPath) as? AccomplishmentTableCell else {
            return UITableViewCell()
        }
        cell.awardName.text = accomplishment[indexPath.row].title
        cell.awardDate.text = accomplishment[indexPath.row].given_date?.string(format: Date.ISO8601Format.MonthYear)
        cell.awardIssuer.text = accomplishment[indexPath.row].issuer
        if accomplishment[indexPath.row].is_selected {
            cell.checklistButtonIfSelected()
        } else {
            cell.checklistButtonUnSelected()
        }
        cell.editButtonAction = {
           
            self.delegate?.passingAccomplishData(accomplish: self.accomplishment[indexPath.row])
        }
        
        if accompData.is_selected == false{
            cell.checklistButtonUnSelected()
        }else{
            cell.checklistButtonIfSelected()
        }
        
        cell.checklistButtonAction = {
            let accomId = self.accomplishment[indexPath.row].accomplishment_id ?? ""
            if cell.selectionStatus == false {
                cell.selectionStatus = true
                cell.checklistButtonIfSelected()
                self.accomplishment[indexPath.row].is_selected = true
                //AccomplishmentRepository.shared.updateSelectedAccomplishStatus(accomId: UUID().uuidString, is_Selected: true)
                self.delegate?.selectButtonAccom(accomId: accomId , isSelected: true)
            }else{
                cell.selectionStatus = false
                cell.checklistButtonUnSelected()
                self.accomplishment[indexPath.row].is_selected = false
                //AccomplishmentRepository.shared.updateSelectedAccomplishStatus(accomId: UUID().uuidString, is_Selected: false)
                self.delegate?.selectButtonAccom(accomId: accomId , isSelected: false)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if accomplishment.count != 0 {
            emptyStateView.isHidden = true
            return accomplishment.count
        } else {
            emptyStateView.isHidden = false
            emptyState = stepViewModel.getEmptyStateId(Id: 4) ?? emptyState
            emptyStateView.emptyStateImage.image = UIImage(data: emptyState.image ?? Data())
            emptyStateView.emptyStateTitle.isHidden = true
            emptyStateView.emptyStateDescription.text = emptyState.title
            self.tableView.backgroundView = emptyStateView
        }
        return accomplishment.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

//MARK: Initial Setup
extension AccomplishmentPageView {
    func registerTableView(){
        tableView.register(AccomplishmentTableCell.nib(), forCellReuseIdentifier: AccomplishmentTableCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func notificationCenterSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(accompReload), name: Notification.Name("accompReload"), object: nil)
    }
}

//MARK: XIB Setting
extension AccomplishmentPageView {
    fileprivate func initWithNib() {
        guard let view = loadViewFromNib(nibName: "AccomplishmentPageView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}


