//
//  ExpertListViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation

class ExpertListViewModel{
    
    func getExpertList() -> [Expert_Profile]?{
        return ExpertProfileRepository.shared.getAllExpertProfile()
    }
    
}
