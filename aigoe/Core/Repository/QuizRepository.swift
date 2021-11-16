//
//  QuizRepository.swift
//  aigoe
//
//  Created by Olivia Dwi  Susanti on 16/11/21.
//

import Foundation
import UIKit
import CoreData

class QuizRepository{
    
    static let shared = QuizRepository()
    let entityName = Quiz.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createQuiz(quiz_id: Int,
                    header: String,
                    desc: String,
                    cue: String){
        do {
            let quiz = Quiz(context: context)
            quiz.quiz_id = Int32(quiz_id)
            quiz.header = header
            quiz.desc = desc
            quiz.cue = cue
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllQuiz() -> [Quiz]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Quiz]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getQuizById(quiz_id: Int) -> Quiz? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "quiz_id == %d", quiz_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Quiz]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }

    // func updates
    func updateQuiz(quiz_id: Int, newHeader: String, newDesc: String, newCue: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "quiz_id == %d", quiz_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Quiz]
            let newQuiz = item?.first
            newQuiz?.header = newHeader
            newQuiz?.desc = newDesc
            newQuiz?.cue = newCue
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    // func delete
    func deleteQuiz(data: Quiz) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}

