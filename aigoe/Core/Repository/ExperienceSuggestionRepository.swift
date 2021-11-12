//
//  ExperienceSuggestionRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 24/10/21.
//

import Foundation
import UIKit
import CoreData

class ExperienceSuggestionRepository{
    
    static let shared = ExperienceSuggestionRepository()
    let entityName = Experience_Suggestion.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createExpSuggestion(exp_suggest_id: Int,
                             exp_id: Int,
                             jobDescSuggest: String){
        do {
            let experienceSuggestion = Experience_Suggestion(context: context)
            experienceSuggestion.exp_suggest_id = Int32(exp_suggest_id)
            experienceSuggestion.exp_id = Int32(exp_id)
            experienceSuggestion.jobDescSuggest = jobDescSuggest
            
            // relation (one-to-one) experience to exp suggestion
            if let experienceSuggestions = ExperienceRepository.shared.getExperienceById(experienceId: exp_id){
                experienceSuggestion.experience = experienceSuggestions
            }
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllExpSuggestion() -> [Experience_Suggestion]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Experience_Suggestion]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getExpSuggestionById(exp_suggest_id: Int) -> Experience_Suggestion? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "exp_suggest_id == %d", exp_suggest_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Experience_Suggestion]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateExpSuggestion(exp_suggest_id: Int,
                             exp_id: Int,
                             newwJobDescSuggest: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "exp_suggest_id == %d", exp_suggest_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Experience_Suggestion]
            let experienceSuggest = item?.first
            experienceSuggest?.jobDescSuggest = newwJobDescSuggest
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteExpSuggestion(data: Experience_Suggestion) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
