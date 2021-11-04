//
//  AccomplishmentSuggestionRepository.swift
//  dayangsurga-macro
//
//  Created by Anya Akbar on 04/11/21.
//

import Foundation
import UIKit
import CoreData

class AccomplishmentSuggestionRepository{
    
    static let shared = AccomplishmentSuggestionRepository()
    let entityName = Accomplishment_Suggest.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createAccomplishmentSuggestion(accomId: Int32,
                                        accomSuggestionId: Int32,
                                        title: String,
                                        desc : String){
        do {
            let accomplishmentSuggestion = Accomplishment_Suggest(context: context)
            accomplishmentSuggestion.accom_id = accomId
            accomplishmentSuggestion.accom_suggest_id = accomSuggestionId
            accomplishmentSuggestion.title = title
            accomplishmentSuggestion.desc = desc
            
            // relation (one-to-one)
            if let accomplishmentItem = AccomplishmentRepository.shared.getAccomplishmentById(AccomplishmentId: Int(accomId) ){
                accomplishmentSuggestion.accomplishment = accomplishmentItem
            }
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllAccomplishmentSuggestion() -> [Accomplishment_Suggest]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplishment_Suggest]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getAccomplishmentSuggestionById(accomSuggestId: Int) -> Accomplishment_Suggest? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "accom_suggest_id == %@", accomSuggestId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplishment_Suggest]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateAccomSuggestion(accomId: Int32,
                               accomSuggestionId: Int32,
                               title: String,
                               desc : String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "accom_suggest_id == %@", accomSuggestionId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplishment_Suggest]
            let AccomSuggestItem = item?.first
            AccomSuggestItem?.title = title
            AccomSuggestItem?.desc = desc
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteAccomplishmentSuggestion(data: Accomplishment_Suggest) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
