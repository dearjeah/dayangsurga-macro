//
//  ExperiencePageView.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class ExperiencePageView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var expTableView: UITableView!
    
    @IBAction func addEditPressed(_ sender: UIButton) {
    }
    
    var cellSpacingHeight = 15.0
    
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableCell") as! ExperienceTableCell
        
        return cell
    }
    
}
