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
    func getAllAccomplishment() -> [Education]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Education]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getEducationById(educationId: Int) -> Education? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "education_id == %@", educationId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Education]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateEducation( eduId: Int,
                          userId: Int,
                          institution: String,
                          title: String,
                          startDate: Date,
                          endDate : Date,
                          gpa: Decimal,
                          activity : String,
                          currentlyStudy : Bool,
                          isSelected : Bool) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "education_id == %@", eduId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Education]
            let education = item?.first
            education?.edu_id = Int32(eduId)
            education?.user_id = Int32(userId)
            education?.title = title
            education?.start_date = startDate
            education?.end_date = endDate
            education?.gpa =  NSDecimalNumber(decimal: gpa)
            education?.activity = activity
            education?.currently_study = currentlyStudy
            education?.is_selected = isSelected
           
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    // func delete
    func deleteUser(data: Education) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}

