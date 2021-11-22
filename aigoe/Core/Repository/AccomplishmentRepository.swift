//
//  Accomplishments.swift
//  dayangsurga-macro
//
//  Created by Anya Akbar on 02/11/21.
//

import Foundation
import UIKit
import CoreData

class AccomplishmentRepository{
    
    static let shared = AccomplishmentRepository()
    let entityName = Accomplishment.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createAccomplishment(accomId: String,
                              userId: Int,
                              title: String,
                              givenDate: Date,
                              endDate: Date,
                              status: Bool,
                              issuer : String,
                              desc : String,
                              isSelected : Bool) -> Bool {
        do {
            // relation accomplishment-user
            if let AccomplishmentToUser = UserRepository.shared.getUserById(id: userId) {
                let accomplishment = Accomplishment(context: context)
                accomplishment.accomplishment_id = accomId
                accomplishment.user_id = Int32(userId)
                accomplishment.given_date = givenDate
                accomplishment.end_date = endDate
                accomplishment.status = status
                accomplishment.title = title
                accomplishment.issuer = issuer
                accomplishment.desc = desc
                accomplishment.is_selected = isSelected
                
                AccomplishmentToUser.addToAccomplishment(accomplishment)
                try context.save()
                return true
            }
        }
        catch let error as NSError {
            print(error)
        }
        return false
    }
    
    // retrieve education
    func getAllAccomplishment() -> [Accomplishment]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplishment]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getAccomplishmentById(AccomplishmentId: String) -> Accomplishment? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "accomplishment_id == %d", AccomplishmentId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplishment]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateAccomplishment( accomId: String,
                               userId: Int,
                               title: String,
                               givenDate: Date,
                               endDate: Date,
                               status: Bool,
                               issuer : String,
                               desc : String,
                               isSelected : Bool) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "accomplishment_id == %d", accomId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplishment]
            let accomplishment = item?.first
            accomplishment?.accomplishment_id = accomId
            accomplishment?.user_id = Int32(userId)
            accomplishment?.given_date = givenDate
            accomplishment?.end_date = endDate
            accomplishment?.status = status
            accomplishment?.title = title
            accomplishment?.issuer = issuer
            accomplishment?.desc = desc
            accomplishment?.is_selected = isSelected
            
            try context.save()
            return true
        } catch let error as NSError {
            print(error)
        }
        
        return false
    }
    
    func updateSelectedAccomplishStatus(accomId: String,
                                        is_Selected: Bool) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "accomplishment_id == %d", accomId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplishment]
            let newAccom = item?.first
            newAccom?.is_selected = is_Selected
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteAccomplishment(data: Accomplishment) -> Bool {
        do {
            context.delete(data)
            try context.save()
            return true
            
        } catch let error as NSError {
            print(error)
        }
        
        return false
    }
}

