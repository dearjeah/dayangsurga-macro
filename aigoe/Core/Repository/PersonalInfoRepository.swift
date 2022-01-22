//
//  PersonalInfoRepository.swift
//  aigoe
//
//  Created by Delvina Janice on 08/01/22.
//

import Foundation
import UIKit
import CoreData

class PersonalInfoRepository{
    
    static let shared = PersonalInfoRepository()
    let entityName = Personal_Info.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createPersonalInfo(user_id: String,
                            fullName: String,
                            phoneNumber: String,
                            email: String,
                            location: String,
                            summary: String) -> Bool {
        do {
            // relation education-user
            let user = Personal_Info(context: context)
            user.user_id = user_id
            user.personalInfo_id = UUID().uuidString
            user.fullName = fullName
            user.phoneNumber = phoneNumber
            user.email = email
            user.location = location
            user.summary = summary
            
            if let personalInfoToUser = UserRepository.shared.getUserById(id: user_id) {
                personalInfoToUser.addToPersonalInfo(user)
            }
            try context.save()
            return true
        }
        catch let error as NSError {
            print(error)
        }
        return false
    }
    
    // retrieve
    func getAllPersonalInfo() -> [Personal_Info]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Personal_Info]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getPersonalInfoById(id: String) -> Personal_Info? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "personalInfo_id == '\(id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [Personal_Info]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updatePersonalInfo(id: String,
                            newName: String,
                            newPhoneNumber: String,
                            newEmail: String,
                            newLocation: String,
                            newSummary: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "personalInfo_id == '\(id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [Personal_Info]
            let user = item?.first
            
            user?.personalInfo_id = id
            user?.fullName = newName
            user?.phoneNumber = newPhoneNumber
            user?.email = newEmail
            user?.location = newLocation
            user?.summary = newSummary
            
            try context.save()
            return true
        } catch let error as NSError {
            print(error)
        }
        return false
    }
    
    // func delete
    func deletePersonalInfo(data: Personal_Info) -> Bool {
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
