//
//  ExpertProfileRepository.swift
//  dayangsurga-macro
//
//  Created by Anya Akbar on 04/11/21.
//

import Foundation
import UIKit
import CoreData

class ExpertProfileRepository{
    
    static let shared = ExpertProfileRepository()
    let entityName = Expert_Profile.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createExpertProfile(expertId: Int,
                             name: String,
                             experience: Int32,
                             expertise: String,
                             phoneNumber: String,
                             availTime : String,
                             linkedIn : String,
                             image :Data){
        do {
            
          
            let expertProfile = Expert_Profile(context: context)
            expertProfile.expert_id = Int32(expertId)
            expertProfile.expert_name = name
            expertProfile.experience = experience
            expertProfile.expertise = expertise
            expertProfile.phone_number = phoneNumber
            expertProfile.avail_time = availTime
            expertProfile.linkedIn = linkedIn
            expertProfile.expert_image = image
                
                
            try context.save()
            
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllExpertProfile() -> [Expert_Profile]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Expert_Profile]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getExpertProfileById(expertId: Int) -> Expert_Profile? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "expert_id == %@", expertId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Expert_Profile]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateExpertProfile( expertId: Int,
                              name: String,
                              experience: Int32,
                              expertise: String,
                              phoneNumber: String,
                              availTime : String,
                              linkedIn : String,
                              image :Data) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "expert_id == %@", expertId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Expert_Profile]
            let expertProfile = item?.first
            expertProfile?.expert_name = name
            expertProfile?.experience = experience
            expertProfile?.expertise = expertise
            expertProfile?.phone_number = phoneNumber
            expertProfile?.avail_time = availTime
            expertProfile?.linkedIn = linkedIn
            expertProfile?.expert_image = image
           
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    // func delete
    func deleteExpertProfile(data: Expert_Profile) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}

