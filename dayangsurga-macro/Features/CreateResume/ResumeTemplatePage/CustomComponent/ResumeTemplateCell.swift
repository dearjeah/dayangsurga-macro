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
    }
}
