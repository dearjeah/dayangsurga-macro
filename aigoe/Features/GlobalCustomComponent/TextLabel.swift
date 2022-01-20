//
//  TextLabel.swift
//  aigoe
//
//  Created by Delvina Janice on 05/01/22.
//

import Foundation
import Foundation
import UIKit

extension UILabel {
    func sectionTitle(title: String){
        self.text = title
        self.textColor = UIColor.black
        self.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
}
