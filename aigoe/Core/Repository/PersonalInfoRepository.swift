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
                    summary: String){
        do {
            let user = Personal_Info(context: context)
            user.user_id = user_id
            user.personalInfo_id = UUID().uuidString
            user.fullName = fullName
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
        fetchRequest.predicate = NSPredicate(format: "personalInfo_id == %d", id as CVarArg)
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
                newSummary: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "perosnalInfo_id == %d", id as CVarArg)
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
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deletePersonalInfo(data: Personal_Info) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
