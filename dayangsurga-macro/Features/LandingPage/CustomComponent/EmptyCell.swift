//
//  EmptyCell.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 28/10/21.
//

import UIKit

class EmptyCell: UICollectionViewCell {
    
    static let identifier = "emptyCell"
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "EmptyCell", bundle: nil)
    }

}
