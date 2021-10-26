//
//  RoundedButton.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation
import UIKit

extension UIButton {
    func dsLongFilledPrimaryButton(withImage: Bool, text: String) {
        let corner_radius : CGFloat =  18.0
        func draw(_ rect: CGRect) {
            super.draw(rect)
            clipsToBounds = true
            layer.cornerRadius = corner_radius
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.primaryBlue.cgColor
            layer.backgroundColor = UIColor.primaryBlue.cgColor
            titleLabel?.tintColor = UIColor.primaryWhite
            titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
            titleLabel?.text = text
            frame.size = CGSize(width: 350, height: 48)
            
            
            if (withImage) {
                self.setImage(UIImage(), for: .normal)
            }
        }
    }
    
    func dsLongUnfilledButton(isDelete: Bool, text: String) {
        let corner_radius : CGFloat =  18.0
        func draw(_ rect: CGRect) {
            super.draw(rect)
            self.clipsToBounds = true
            self.layer.cornerRadius = corner_radius
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor.primaryBlue.cgColor
            self.layer.backgroundColor = UIColor.primaryWhite.cgColor
            self.titleLabel?.tintColor = UIColor.primaryBlue
            self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
            self.titleLabel?.text = text
            frame.size = CGSize(width: 350, height: 48)
            
            if (isDelete) {
                self.layer.borderColor = UIColor.primaryRed.cgColor
                self.titleLabel?.tintColor = UIColor.primaryRed
            }
        }
    }
    
    func dsShortFilledPrimaryButton(text: String) {
        let corner_radius : CGFloat =  18.0
        func draw(_ rect: CGRect) {
            super.draw(rect)
            clipsToBounds = true
            layer.cornerRadius = corner_radius
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.primaryBlue.cgColor
            layer.backgroundColor = UIColor.primaryBlue.cgColor
            titleLabel?.tintColor = UIColor.primaryWhite
            titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
            titleLabel?.text = text
            frame.size = CGSize(width: 160, height: 48)
        }
    }
    
    func dsShortUnfilledButton(isDelete: Bool, text: String) {
        let corner_radius : CGFloat =  18.0
        func draw(_ rect: CGRect) {
            super.draw(rect)
            self.clipsToBounds = true
            self.layer.cornerRadius = corner_radius
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor.primaryBlue.cgColor
            self.layer.backgroundColor = UIColor.primaryWhite.cgColor
            self.titleLabel?.tintColor = UIColor.primaryBlue
            self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
            self.titleLabel?.text = text
            frame.size = CGSize(width: 160, height: 48)
            
            if (isDelete) {
                self.layer.borderColor = UIColor.primaryRed.cgColor
                self.titleLabel?.tintColor = UIColor.primaryRed
            }
        }
    }
    
}


