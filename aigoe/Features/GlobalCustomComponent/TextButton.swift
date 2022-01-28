//
//  TextButton.swift
//  aigoe
//
//  Created by Delvina Janice on 05/01/22.
//

import Foundation
import UIKit

extension UIButton {
    func mediumTextButton(color: UIColor){
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
    }
}
