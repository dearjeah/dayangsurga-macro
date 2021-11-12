//
//  ExperienceRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 24/10/21.
//

import Foundation
import UIKit
import CoreData

class ExperienceRepository{
    
    static let shared = ExperienceRepository()
    let entityName = Experience.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createExperience(exp_id: Int,
                          user_id: Int,
                          jobTitle: String,
                          jobDesc: String,
                          jobCompanyName: String,
                          jobStartDate: Date,
                          jobEndtDate: Date,
                          jobStatus: Bool,
                          isSelected: Bool){
        do {
            if let experienceToUser = UserRepository.shared.getUserById(id: user_id) {
                let experience = Experience(context: context)
                experience.exp_id = Int32(exp_id)
                experience.user_id = Int32(user_id)
                experience.jobTitle = jobTitle
                experience.jobDesc = jobDesc
                experience.jobCompanyName = jobCompanyName
                experience.jobStartDate = jobStartDate
                experience.jobEndDate = jobEndtDate
                experience.jobStatus = jobStatus
                experience.isSelected = isSelected
                
                experienceToUser.addToExperience(experience)
                try context.save()
            }
        }
        catch let error as NSError {
            print(error)
        }
    }

    // retrieve
    func getAllExperience() -> [Experience]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Experience]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getExperienceById(experienceId: Int) -> Experience? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "exp_id == %d", experienceId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Experience]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateExperience(exp_id: Int,
                              user_id: Int,
                              newJobTitle: String,
                              newJobDesc: String,
                              newJobCompanyName: String,
                              newJobStartDate: Date,
                              newJobEndtDate: Date,
                              newJobStatus: Bool,
                              newIsSelected: Bool) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "exp_id == %d", exp_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Experience]
            let newExp = item?.first
            newExp?.jobTitle = newJobTitle
            newExp?.jobDesc = newJobDesc
            newExp?.jobCompanyName = newJobCompanyName
            newExp?.jobStartDate = newJobStartDate
            newExp?.jobEndDate = newJobEndtDate
            newExp?.jobStatus = newJobStatus
            newExp?.isSelected = newIsSelected
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func updateSelectedExpStatus(exp_id: Int,
                              isSelected: Bool) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "exp_id == %d", exp_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Experience]
            let newExp = item?.first
            newExp?.isSelected = isSelected
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteExperience(data: Experience) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}


