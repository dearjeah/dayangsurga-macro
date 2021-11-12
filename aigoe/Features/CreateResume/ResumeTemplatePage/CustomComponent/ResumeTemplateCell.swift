//
//  ResumeTemplateCell.swift
//  dayangsurga-macro
//
//  Created by Audrey Aurelia Chang on 23/10/21.
//

import UIKit

class ResumeTemplateCell: UICollectionViewCell {
    
    @IBOutlet weak var resumeTemplateImage: UIImageView!
    
    override func awakeFromNib() {
        resumeTemplateImage.layer.cornerRadius = 8
        self.layer.shadowRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .init(width: 10, height: 10)
    }
}
