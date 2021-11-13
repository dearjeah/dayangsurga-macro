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
    func getSelectedIndex(index: Int)
}

class AccomplishmentPageView: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var emptyStateView: EmptyState!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    var totalData = 1
    
    weak var delegate: AccomplishListDelegate?
    var stepViewModel = StepByStepGuideViewModel()
    var emptyState = Empty_State()
    var accomplishment = [Accomplishment]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        registerTableView()
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        registerTableView()
        tableView.autoresizingMask = UIView.AutoresizingMask()
        emptyState = stepViewModel.getEmptyStateId(Id: 4) ?? emptyState
        accomplishment = stepViewModel.getAccomplishData() ?? accomplishment
        tableView.reloadData()
    }
    
    convenience init(text: String) {
        self.init()
    }
    
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
    
    func registerTableView(){
        tableView.register(AccomplishmentTableCell.nib(), forCellReuseIdentifier: AccomplishmentTableCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func addAction(_ sender: Any) {
        delegate?.goToAddAccom()
    }
    
    // setup table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccomplishmentTableCell.identifier, for: indexPath) as? AccomplishmentTableCell else {
            return UITableViewCell()
        }
        cell.awardName.text = accomplishment[indexPath.row].title
        cell.awardDate.text = accomplishment[indexPath.row].given_date?.string(format: Date.ISO8601Format.MonthYear)
        cell.awardIssuer.text = accomplishment[indexPath.row].issuer
        cell.editButtonAction = {
            self.delegate?.getSelectedIndex(index: indexPath.row)
            self.delegate?.passingAccomplishData(accomplish: self.accomplishment[indexPath.row])
        }
        cell.checklistButtonAction = {
            self.delegate?.getSelectedIndex(index: indexPath.row)
            if cell.selectionStatus == false{
                cell.selectionStatus = true
                cell.checklistButtonIfSelected()
                self.accomplishment[indexPath.row].is_selected = true
                AccomplishmentRepository.shared.updateSelectedAccomplishStatus(accomId: indexPath.row, is_Selected: true)
            }else{
                cell.selectionStatus = false
                cell.checklistButtonUnSelected()
                self.accomplishment[indexPath.row].is_selected = false
                AccomplishmentRepository.shared.updateSelectedAccomplishStatus(accomId: indexPath.row, is_Selected: false)
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
            emptyStateView.emptyStateTitle.text = nil
            emptyStateView.emptyStateDescription.text = emptyState.description
            self.tableView.backgroundView = emptyStateView
        }
        return accomplishment.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("dyusfgyasyu")
//    }
    
    func getAndReload(){
        accomplishment = stepViewModel.getAccomplishData() ?? []
        tableView.reloadData()
    }

}
