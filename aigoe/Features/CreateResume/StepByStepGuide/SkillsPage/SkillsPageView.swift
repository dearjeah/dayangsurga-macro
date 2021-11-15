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
}

class SkillsPageView: UIView, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var skillsTableView: UITableView!
    @IBOutlet weak var emptyStateView: EmptyState!
    
    weak var delegate: skillListDelegate?
    
    let skillDataCount = 1
    
    @IBAction func addEditPressed(_ sender: UIButton) {
       //go to add form
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
        print("olip cantik")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if skillDataCount == 0 {
            emptyStateView.emptyStateImage.image = UIImage.imgSkillEmptyState
            emptyStateView.emptyStateDescription.text = "You haven’t filled your skills. Click the ‘Add’ button to add your technical skills."
            self.skillsTableView.backgroundView = emptyStateView
        } else {
            emptyStateView.isHidden = true
        }
        return skillDataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TechnicalSkillsListCell") as! TechnicalSkillsListCell
        
        return cell
    }
    

}
