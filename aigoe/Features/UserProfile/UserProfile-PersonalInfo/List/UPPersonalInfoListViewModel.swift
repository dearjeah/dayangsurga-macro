//
//  UPPersonalInfoListViewModel.swift
//  aigoe
//
//  Created by Delvina Janice on 24/12/21.
//

import Foundation

class UPPersonalInfoListViewModel: NSObject {
    
    func getAllPersonalInfo() -> [Personal_Info] {
        guard let data = PersonalInfoRepository.shared.getAllPersonalInfo() else {
            return [Personal_Info]()}
        return data
    }
}
