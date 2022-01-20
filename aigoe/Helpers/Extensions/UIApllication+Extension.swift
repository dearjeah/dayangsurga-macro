//
//  UIApllication+Extension.swift
//  aigoe
//
//  Created by Delvina Janice on 10/01/22.
//

import Foundation
import UIKit

private var firstLaunch : Bool = false

extension UIApplication {

    static func isFirstLaunch() -> Bool {
        let firstLaunchFlag = "isFirstLaunchFlag"
        let isFirstLaunch = UserDefaults.standard.string(forKey: firstLaunchFlag) == nil
        if (isFirstLaunch) {
            firstLaunch = isFirstLaunch
            UserDefaults.standard.set("false", forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
        }
        return firstLaunch || isFirstLaunch
    }
}
