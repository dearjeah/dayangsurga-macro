//
//  AccomplishmentPageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol AccomplishListDelegate: AnyObject {
    func goToAddAccom()
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        registerTableView()
        
        emptyState = stepViewModel.getEmptyStateId(Id: 4) ?? emptyState
//        experience = stepViewModel.getExpData() ?? []
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
        cell.awardName.text = "App Development Swift Certification"
        cell.awardDate.text = "May 2020"
        cell.awardIssuer.text = "Swift.co"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if accomplishment.count != 0 {
            emptyStateView.isHidden = true
            return accomplishment.count
        } else {
            emptyStateView.isHidden = false
            emptyStateView.emptyStateImage.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
            emptyStateView.emptyStateImage.contentMode = .scaleAspectFit
            emptyStateView.emptyStateImage.clipsToBounds = true
            
            emptyStateView.emptyStateImage.image = UIImage(named: "imgEmptyStateAccom")
            emptyStateView.emptyStateDescription.text = "You have no accomplishment yet. Click the ‘Add’ button to add your certificates or awards."
            self.tableView.backgroundView = emptyStateView
        }
        return Int()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 // +12 bottom
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}
