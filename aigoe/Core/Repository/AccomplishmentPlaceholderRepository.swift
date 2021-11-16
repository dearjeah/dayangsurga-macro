//
//  AccomplishmentPlaceholderRepository.swift
//  dayangsurga-macro
//
//  Created by Anya Akbar on 04/11/21.
//

import Foundation
import UIKit
import CoreData

class AccomplishmentPlaceholderRepository{
    
    static let shared = AccomplishmentPlaceholderRepository()
    let entityName = Accomplish_Placeholder.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create
    func createAccomplishmentPlaceholder(accomId: String,
                                    accomPlaceholderId:Int,
                                    titlePlaceholder: String,
                                    givenDatePlaceholder : String
                                    ){
        do {
            let accomplishmentPlaceholder = Accomplish_Placeholder(context: context)
            accomplishmentPlaceholder.accomplishment_id = accomId
            accomplishmentPlaceholder.accom_ph_id = Int32(accomPlaceholderId)
            accomplishmentPlaceholder.title_ph = titlePlaceholder
            accomplishmentPlaceholder.given_date_ph = givenDatePlaceholder
            
            // relation (one-to-one)
            if let accomplishmentItem = AccomplishmentRepository.shared.getAccomplishmentById(AccomplishmentId: accomId){
                accomplishmentPlaceholder.accomplishment = accomplishmentItem
            }
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllAccomplishmentPlaceholder() -> [Accomplish_Placeholder]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplish_Placeholder]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getAccomplishmentPlaceholderById(id: Int) -> Accomplish_Placeholder? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "accom_ph_id == %d", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplish_Placeholder]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateAccomplishmentPlaceholder(accomId: String,
                                         accomPlaceholderId:Int,
                                         titlePlaceholder: String,
                                         givenDatePlaceholder : String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "accom_ph_id == %d", accomPlaceholderId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplish_Placeholder]
            let accomplishmentPlaceholder = item?.first
            
            accomplishmentPlaceholder?.title_ph = titlePlaceholder
            accomplishmentPlaceholder?.given_date_ph = givenDatePlaceholder
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteAccomplishmentPlacheholder(data: Accomplish_Placeholder) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
