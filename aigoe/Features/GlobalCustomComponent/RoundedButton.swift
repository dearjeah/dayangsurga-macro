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
        
        self.clipsToBounds = true
        self.layer.cornerRadius = corner_radius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.primaryBlue.cgColor
        self.layer.backgroundColor = UIColor.primaryBlue.cgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        self.setTitle(text, for: .normal)
        self.setTitleColor(UIColor.primaryWhite, for: .normal)
        self.frame.size = CGSize(width: 350, height: 48)
        
        if (withImage) {
            self.setImage(UIImage(), for: .normal)
        }
    }
    
    func dsLongUnfilledButton(isDelete: Bool, text: String) {
        let corner_radius : CGFloat =  18.0
        
        self.clipsToBounds = true
        self.layer.cornerRadius = corner_radius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.primaryBlue.cgColor
        self.layer.backgroundColor = UIColor.primaryWhite.cgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        self.setTitle(text, for: .normal)
        self.setTitleColor(UIColor.primaryBlue, for: .normal)
        frame.size = CGSize(width: 350, height: 48)
        
        if (isDelete) {
            self.layer.borderColor = UIColor.primaryRed.cgColor
            self.setTitleColor(UIColor.primaryRed, for: .normal)
        }
    }
    
    func dsShortFilledPrimaryButton(isDisable: Bool, text: String) {
        let corner_radius : CGFloat =  18.0
        
        self.clipsToBounds = true
        self.layer.cornerRadius = corner_radius
        self.layer.borderWidth = 1.0
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        self.setTitle(text, for: .normal)
        self.setTitleColor(UIColor.primaryWhite, for: .normal)
        self.frame.size = CGSize(width: 160, height: 48)
        
        if (isDisable) {
            layer.borderColor = UIColor.primaryDisable.cgColor
            layer.backgroundColor = UIColor.primaryDisable.cgColor
        }
    }
    
    func dsShortUnfilledButton(isDelete: Bool, isDisable: Bool, text: String) {
        let corner_radius : CGFloat =  18.0
        self.clipsToBounds = true
        self.layer.cornerRadius = corner_radius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.primaryBlue.cgColor
        self.layer.backgroundColor = UIColor.primaryWhite.cgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        self.setTitle(text, for: .normal)
        self.setTitleColor(UIColor.primaryBlue, for: .normal)
        self.frame.size = CGSize(width: 160, height: 48)
        
        if (isDelete) {
            self.layer.borderColor = UIColor.primaryRed.cgColor
            self.titleLabel?.tintColor = UIColor.primaryRed
        } else if (isDisable) {
            self.layer.borderColor = UIColor.primaryDisable.cgColor
            self.setTitleColor(UIColor.primaryDisable, for: .normal)
        }
    }
}


