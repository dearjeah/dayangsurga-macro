//
//  EducationSuggestionRepository.swift
//  dayangsurga-macro
//
//  Created by Anya Akbar on 03/11/21.
//

import Foundation
import UIKit
import CoreData

class EducationSuggestionRepository{
    
    static let shared = EducationSuggestionRepository()
    let entityName = Edu_Suggestion.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create
    func createEducationSuggestion(eduId: Int,
                                    eduSuggestionId:Int,
                                    activitySuggestion: String
                                    ){
        do {
            let educationSuggestion = Edu_Suggestion(context: context)
            educationSuggestion.edu_id = Int32(eduId)
            educationSuggestion.edu_suggest_id =  Int32(eduSuggestionId)
            educationSuggestion.activity_suggest = activitySuggestion
            
            // relation (one-to-one)
            if let educationItem = EducationRepository.shared.getEducationById(educationId: eduId){
                educationSuggestion.education = educationItem
            }
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllEducationSuggestion() -> [Edu_Suggestion]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Edu_Suggestion]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getEducationSuggestionById(id: Int) -> Edu_Suggestion? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "edu_suggest_id == %d", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Edu_Suggestion]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateEducationPlaceholder(eduId: Int,
                                    eduSuggestionId:Int,
                                    activitySuggestion: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "edu_suggest_id == %@", eduId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Edu_Suggestion]
            let educationSuggestion = item?.first
            
            educationSuggestion?.activity_suggest = activitySuggestion
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteEducationSuggestion(data: Edu_Suggestion) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
