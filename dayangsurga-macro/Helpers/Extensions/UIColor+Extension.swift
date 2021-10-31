//
//  UIColor+Extension.swift
//  dayangsurga-macro
//
//  Created by Dayang Surga Team.
//  swiftlint:disable all

import UIKit

// MARK: - Colors Asset

extension UIColor {

    static let primaryBG = UIColor.color(named: "primaryBG")
    static let primaryBlue = UIColor.color(named: "primaryBlue")
    static let primaryDisable = UIColor.color(named: "primaryDisable")
    static let primaryDisableDark = UIColor.color(named: "primaryDisableDark")
    static let primaryRed = UIColor.color(named: "primaryRed")
    static let primarySubtitle = UIColor.color(named: "primarySubtitle")
    static let primaryWhite = UIColor.color(named: "primaryWhite")
    static let primaryYellow = UIColor.color(named: "primaryYellow")
    static let textviewBorder = UIColor.color(named: "textviewBorder")

    private static func color(named: String) -> UIColor {
        return UIColor(named: named)!
    }

}

