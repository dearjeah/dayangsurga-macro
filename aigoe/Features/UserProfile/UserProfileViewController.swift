//
//  ViewController.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var comingSoon: EmptyState!
    override func viewDidLoad() {
        super.viewDidLoad()
        setComingSoon()
        self.title = "Profile"
        navigationStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.sizeToFit()
    }
    
    func setComingSoon() {
        comingSoon.emptyStateImage.image = UIImage.comingSoon
        comingSoon.emptyStateTitle.font = UIFont.boldSystemFont(ofSize: 20.0)
        comingSoon.emptyStateTitle.textColor = UIColor.primaryBlue
        comingSoon.emptyStateTitle.text = "Coming Soon"
        comingSoon.emptyStateDescription.text = "Features are currently in progress"
        comingSoon.emptyStateDescription.font = UIFont.systemFont(ofSize: 17)
        comingSoon.emptyStateDescription.textColor = UIColor.primaryBlue
    }
    
    func navigationStyle(){
        configureNavigationBar(largeTitleColor: .white, backgoundColor:UIColor.primaryBlue, tintColor: UIColor.white, title: "Profile", preferredLargeTitle: true, hideBackButton: false)
    }


}

