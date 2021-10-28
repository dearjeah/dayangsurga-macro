//
//  ResumeCell.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 27/10/21.
//

import UIKit

class ResumeCell: UICollectionViewCell {
    
    static let identifier = "resumeCell"
    @IBOutlet weak var pastResumeImage: UIImageView!
    @IBOutlet weak var resumeName: UILabel!
    @IBOutlet weak var resumeLatestDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ResumeCell", bundle: nil)
    }
}
