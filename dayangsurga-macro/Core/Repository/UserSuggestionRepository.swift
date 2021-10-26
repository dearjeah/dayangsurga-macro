//
//  UserSuggestionRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 24/10/21.
//

import Foundation
import UIKit
import CoreData

class UserSuggestionRepository{
    
    static let shared = UserSuggestionRepository()
    let entityName = User_Suggestion.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createUserSuggestion(user_suggestion_id: Int,
                              user_id: Int,
                              summarySuggest: String){
        do {
            let userSuggestion = User_Suggestion(context: context)
            userSuggestion.user_suggestion_id = Int32(user_suggestion_id)
            userSuggestion.user_id = Int32(user_id)
            userSuggestion.summarySuggest = summarySuggest
            
            // relation (one-to-one) user to user suggest
            if let userSuggestions = UserRepository.shared.getUserById(id: user_id){
                userSuggestion.user = userSuggestions
            }
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllUserSuggest() -> [User_Suggestion]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [User_Suggestion]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getUserSuggestById(suggestionId: Int) -> User_Suggestion? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "user_suggestion_id == %@", suggestionId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [User_Suggestion]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateUserSuggestion(suggestionId: Int,
                              userId: Int,
                              newSummarySuggest: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "user_suggestion_id == %@", suggestionId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [User_Suggestion]
            let userSuggestion = item?.first
            
            userSuggestion?.summarySuggest = newSummarySuggest
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteUserSuggestion(data: User_Suggestion) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
