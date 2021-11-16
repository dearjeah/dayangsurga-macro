//
//  PreloadQuizData.swift
//  aigoe
//
//  Created by Olivia Dwi  Susanti on 16/11/21.
//

import Foundation
import UIKit

func preloadQuiz(){
    /*
     id 0 = experience
     id 1 = skills
     id 2 = accomplish
     */
    
    QuizRepository.shared.createQuiz(quiz_id: 0,
                                     header: "Experience Question",
                                     desc: "Do you have any professional experience?",
                                     cue: "Example: Internship, Apprentice Program, etc.")
    QuizRepository.shared.createQuiz(quiz_id: 1,
                                     header: "Skills Question",
                                     desc: "Do you have any technical skills that related to the role that you want to apply?",
                                     cue: "Example: Swift Programming, Sketch, Figma, Illustration, Project Management, etc.")
    QuizRepository.shared.createQuiz(quiz_id: 2,
                                     header: "Accomplishment Question",
                                     desc: "Do you have any accomplishment?",
                                     cue: "Example: Certification of Project Management, IELTS, Graduate Level Certification in Data Science, etc.")
}
