//
//  ExperiencePlaceholderRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 24/10/21.
//

import Foundation
import UIKit
import CoreData

class ExperiencePlaceholderRepository{
    
    static let shared = ExperiencePlaceholderRepository()
    let entityName = Experience_Placeholder.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createExpPh(exp_ph_id: Int,
                     exp_id: Int,
                     jobTitle_Ph: String,
                     jobDesc_ph: String,
                     companyName_ph: String){
        do {
            let experiencePlaceholder = Experience_Placeholder(context: context)
            experiencePlaceholder.exp_ph_id = Int32(exp_ph_id)
            experiencePlaceholder.exp_id = Int32(exp_id)
            experiencePlaceholder.jobTitle_ph = jobTitle_Ph
            experiencePlaceholder.jobDesc_ph = jobDesc_ph
            experiencePlaceholder.companyName_ph = companyName_ph
            
            // relation (one-to-one) experience to exp placeholder
            if let experiencePlaceholders = ExperienceRepository.shared.getExperienceById(experienceId: exp_id){
                experiencePlaceholder.experience = experiencePlaceholders
            }
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllExpPh() -> [Experience_Placeholder]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Experience_Placeholder]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getExpPhById(id: Int) -> Experience_Placeholder? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "exp_ph_id == %@", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Experience_Placeholder]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateExpPh(exp_ph_id: Int,
                     exp_id: Int,
                     newJobTitle_Ph: String,
                     newJobDesc_ph: String,
                     newCompanyName_ph: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "exp_ph_id == %@", exp_ph_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Experience_Placeholder]
            let experiencePlaceholder = item?.first
            
            experiencePlaceholder?.jobTitle_ph = newJobTitle_Ph
            experiencePlaceholder?.jobDesc_ph = newJobDesc_ph
            experiencePlaceholder?.companyName_ph = newCompanyName_ph
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteExpPh(data: Experience_Placeholder) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
