//
//  LandingPageViewModel.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import UIKit

class LandingPageViewModel {
    
    var image: UIImage
    var name: String
    var date: String

    init(image: UIImage, name: String, date: String){
        self.image = image
        self.name = name
        self.date = date
    }
    
    // dummy data
    static let resumes = [LandingPageViewModel(image: UIImage(systemName: "doc.text") ?? UIImage(), name: "Resume 1", date: "Mon, 11 Oct 2021"),
                          LandingPageViewModel(image: UIImage(systemName: "doc.text") ?? UIImage(), name: "Resume 2", date: "Mon, 11 Oct 2021"),
                          LandingPageViewModel(image: UIImage(systemName: "doc.text.below.ecg") ?? UIImage(), name: "Resume 3", date: "Mon, 11 Oct 2021"),
                          LandingPageViewModel(image: UIImage(systemName: "list.bullet.rectangle.portrait") ?? UIImage(), name: "Resume 4", date: "Mon, 11 Oct 2021"),
                          LandingPageViewModel(image: UIImage(systemName: "doc.richtext") ?? UIImage(), name: "Resume 5", date: "Mon, 11 Oct 2021"),
                          LandingPageViewModel(image: UIImage(systemName: "doc.append") ?? UIImage(), name: "Resume 6", date: "Mon, 11 Oct 2021")
    ]
    
}
