//
//  UserRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 23/10/21.
//

import Foundation
import UIKit
import CoreData

class UserRepository {
    
    static let shared = UserRepository()
    let entityName = User.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    var currentUserId =  UserDefaults.standard.string(forKey: "currentUserId")
    
    // create data
    func createUser(user_id: String,
                    username: String,
                    email: String,
                    password: String){
        do {
            let user = User(context: context)
            user.user_id = user_id
            user.username = username
            user.email = email
            user.password = password
            
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
    
    func getUserById(id: String) -> User? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "user_id == '\(id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [User]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateUser(id: String,
                newUsername: String,
                newEmail: String,
                newPassword: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "user_id == '\(id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [User]
            let user = item?.first
            
            user?.user_id = id
            user?.username = newUsername
            user?.email = newEmail
            user?.password = newPassword
            
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
