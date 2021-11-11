//
//  ExpertDetailViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation

class ExpertDetailViewModel {
    func getExpertInfo(indexPath: Int)->Expert_Profile?{
        return ExpertProfileRepository.shared.getExpertProfileById(expertId: indexPath)
    }
}
