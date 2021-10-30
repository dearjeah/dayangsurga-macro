//
//  ExperiencePageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

protocol SteByStepGuideDelegate {
    func goToAddEdit(pageName: String)
}

class ExperiencePageView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var expTableView: UITableView!
    @IBOutlet weak var emptyStateView: EmptyState!
    
    
    @IBAction func addEditPressed(_ sender: UIButton) {
        
    }
    
    var expDataCount = 1
    var expDlgt: ExperiencePageDelegate?
    
    func setup(expDlgt: ExperiencePageDelegate?) {
        self.expDlgt = expDlgt
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        
        expTableView.delegate = self
        expTableView.dataSource = self
        self.expTableView.register(UINib(nibName: "ExperienceTableCell", bundle: nil), forCellReuseIdentifier: "ExperienceTableCell")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
        
        self.expTableView.register(UINib(nibName: "ExperienceTableCell", bundle: nil), forCellReuseIdentifier: "ExperienceTableCell")
    }
    
    convenience init() {
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
        if expDataCount == 0 {
            emptyStateView.emptyStateImage.image = UIImage.imgExpEmptyState
            emptyStateView.emptyStateDescription.text = "You haven’t filled your professional experience. Click the ‘Add’ button to add your professional experience."
            self.expTableView.backgroundView = emptyStateView
        } else {
            emptyStateView.isHidden = true
        }
        return expDataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableCell") as! ExperienceTableCell
        
        return cell
    }
}

extension ExperiencePageView: ExperiencePageDelegate {
    func addExperience() {
        //update table view
    }
}
