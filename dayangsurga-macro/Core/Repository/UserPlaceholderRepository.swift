//
//  UserPlaceholderRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 24/10/21.
//

import Foundation
import UIKit
import CoreData

class UserPlaceholderRepository{
    
    static let shared = UserPlaceholderRepository()
    let entityName = User_Placeholder.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createUserPh(user_ph_id: Int,
                      user_id: Int,
                      name_ph: String,
                      phoneNumber_ph: String,
                      email_ph: String,
                      address_ph: String,
                      summary_ph: String){
        do {
            // relation (one-to-one) user to user ph
            if let getUser = UserRepository.shared.getUserById(id: user_id){
                let userPlaceholder = User_Placeholder(context: context)
                userPlaceholder.user_ph_id = Int32(user_ph_id)
                userPlaceholder.user_id = Int32(user_id)
                userPlaceholder.name_ph = name_ph
                userPlaceholder.phoneNumber_ph = phoneNumber_ph
                userPlaceholder.email_ph = email_ph
                userPlaceholder.address_ph = address_ph
                userPlaceholder.summary_ph = summary_ph
                
                userPlaceholder.user = getUser
                try context.save()
            }
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllUserPh() -> [User_Placeholder]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [User_Placeholder]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getUserPhById(userPhId: Int) -> User_Placeholder? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "user_ph_id == %@", userPhId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [User_Placeholder]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateUserPh(user_ph_id: Int,
                      user_id: Int,
                      newName_ph: String,
                      newPhoneNumber_ph: String,
                      newEmail_ph: String,
                      newAddress_ph: String,
                      newSummary_ph: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "user_ph_id == %@", user_ph_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [User_Placeholder]
            let userPlaceholder = item?.first
            
            userPlaceholder?.name_ph = newName_ph
            userPlaceholder?.phoneNumber_ph = newPhoneNumber_ph
            userPlaceholder?.email_ph = newEmail_ph
            userPlaceholder?.address_ph = newEmail_ph
            userPlaceholder?.summary_ph = newSummary_ph
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteUserPh(data: User_Placeholder) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
