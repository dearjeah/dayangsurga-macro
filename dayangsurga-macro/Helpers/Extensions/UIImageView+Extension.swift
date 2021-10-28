//
//  UIImageView+Extension.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 28/10/21.
//

import UIKit

extension UIImageView {
    func addShadow() {
        layer.shadowColor = UIColor.tertiaryLabel.cgColor
        layer.shadowOffset = CGSize(width: 6, height: 3)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 6
        layer.cornerRadius = 8
        clipsToBounds = false
    }
}
