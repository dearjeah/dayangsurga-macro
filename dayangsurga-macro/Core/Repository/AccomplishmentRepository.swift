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
    func createAccomplishment(accomId: Int,
                             userId: Int,
                             title: String,
                             givenDate: Date,
                             issuer : String,
                             desc : String,
                             isSelected : Bool){
        do {
            // relation accomplishment-user
            if let AccomplishmentToUser = UserRepository.shared.getUserById(id: userId) {
                let accomplishment = Accomplishment(context: context)
                accomplishment.accom_id = Int32(accomId)
                accomplishment.user_id = Int32(userId)
                accomplishment.given_date = givenDate
                accomplishment.title = title
                accomplishment.issuer = issuer
                accomplishment.desc = desc
                accomplishment.is_selected = isSelected
                
                AccomplishmentToUser.addToAccomplishment(accomplishment)
                try context.save()
            }
        }
        catch let error as NSError {
            print(error)
        }
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
    
    func getAccomplishmentById(AccomplishmentId: Int) -> Accomplishment? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "accomplishment_id == %@", AccomplishmentId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplishment]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateAccomplishment( accomId: Int,
                               userId: Int,
                               title: String,
                               givenDate: Date,
                               issuer : String,
                               desc : String,
                               isSelected : Bool) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "accomplishment_id == %@", accomId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Accomplishment]
            let accomplishment = item?.first
            accomplishment?.accom_id = Int32(accomId)
            accomplishment?.user_id = Int32(userId)
            accomplishment?.given_date = givenDate
            accomplishment?.title = title
            accomplishment?.issuer = issuer
            accomplishment?.desc = desc
            accomplishment?.is_selected = isSelected
         
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    // func delete
    func deleteAccomplishment(data: Accomplishment) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
