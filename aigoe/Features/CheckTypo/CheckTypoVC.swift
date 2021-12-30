//
//  CheckTypoVC.swift
//  aigoe
//
//  Created by Delvina Janice on 28/12/21.
//

import UIKit

class CheckTypoVC: UIViewController {

    @IBOutlet weak var emptyState: EmptyState!
    override func viewDidLoad() {
        super.viewDidLoad()

        setComingSoon()
    }
    func setComingSoon() {
        emptyState.emptyStateImage.image = UIImage.comingSoon
        emptyState.emptyStateTitle.font = UIFont.boldSystemFont(ofSize: 20.0)
        emptyState.emptyStateTitle.textColor = UIColor.primaryBlue
        emptyState.emptyStateTitle.text = "Coming Soon"
        emptyState.emptyStateDescription.text = "Features are currently in progress"
        emptyState.emptyStateDescription.font = UIFont.systemFont(ofSize: 17)
        emptyState.emptyStateDescription.textColor = UIColor.primaryBlue
    }
}
