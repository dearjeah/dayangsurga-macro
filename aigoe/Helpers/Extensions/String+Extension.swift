//
//  String+Extension.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation
import UIKit

extension String {
    func withBoldText(text: String, font: UIFont? = nil, textBoldcolor: UIColor) -> NSMutableAttributedString {
        // swiftlint:disable identifier_name
        let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .light)
        // swiftlint:enable identifier_name
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize), NSAttributedString.Key.foregroundColor: textBoldcolor]
        let range = (self as NSString).range(of: text)
        fullString.addAttributes(boldFontAttribute, range: range)
        return fullString
    }}
