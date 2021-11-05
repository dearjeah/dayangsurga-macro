//
//  UserSuggestionRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 24/10/21.
//

import Foundation
import UIKit
import CoreData

class PersonalInformationSuggestionRepository{
    
    static let shared = PersonalInformationSuggestionRepository()
    let entityName = PersonalInformation_Suggestion.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createPISuggestion(pi_suggestion_id: Int,
                            user_id: Int,
                            summarySuggest: String){
        do {
            if let getUser = UserRepository.shared.getUserById(id: user_id){
                let piSuggestion = PersonalInformation_Suggestion(context: context)
                piSuggestion.pi_suggestion_id = Int32(pi_suggestion_id)
                piSuggestion.user_id = Int32(user_id)
                piSuggestion.summarySuggest = summarySuggest
                
                piSuggestion.user = getUser
                try context.save()
            }
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllPISuggestion() -> [PersonalInformation_Suggestion]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [PersonalInformation_Suggestion]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getPISuggestionById(pi_suggestion_id: Int) -> PersonalInformation_Suggestion? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "pi_suggestion_id == %d", pi_suggestion_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [PersonalInformation_Suggestion]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updatePISuggestion(pi_suggestion_id: Int,
                            userId: Int,
                            newSummarySuggest: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "pi_suggestion_id == %d", pi_suggestion_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [PersonalInformation_Suggestion]
            let piSuggestion = item?.first
            
            piSuggestion?.summarySuggest = newSummarySuggest
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deletePISuggestion(data: PersonalInformation_Suggestion) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
