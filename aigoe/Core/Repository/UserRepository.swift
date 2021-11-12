//
//  UserRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 23/10/21.
//

import Foundation
import UIKit
import CoreData

class UserRepository{
    
    static let shared = UserRepository()
    let entityName = User.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createUser(user_id: Int,
                    username: String,
                    phoneNumber: String,
                    email: String,
                    location: String,
                    summary: String){
        do {
            let user = User(context: context)
            user.user_id = Int32(user_id)
            user.username = username
            user.phoneNumber = phoneNumber
            user.email = email
            user.location = location
            user.summary = summary
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllUser() -> [User]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [User]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getUserById(id: Int) -> User? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "user_id == %d", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [User]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateUser(id: Int,
                newName: String,
                newPhoneNumber: String,
                newEmail: String,
                newLocation: String,
                newSummary: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "user_id == %d", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [User]
            let user = item?.first
            
            user?.username = newName
            user?.phoneNumber = newPhoneNumber
            user?.email = newEmail
            user?.location = newLocation
            user?.summary = newSummary
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteUser(data: User) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
