//
//  EducationRepository.swift
//  dayangsurga-macro
//
//  Created by Anya Akbar on 02/11/21.
//
import Foundation
import UIKit
import CoreData

class EducationRepository{
    
    static let shared = EducationRepository()
    let entityName = Education.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createEducation(    eduId: Int,
                             userId: Int,
                             institution: String,
                             title: String,
                             startDate: Date,
                             endDate : Date,
                             gpa: Float,
                             activity : String,
                             currentlyStudy : Bool,
                             isSelected : Bool) -> Bool {
        do {
            // relation education-user
            if let educationToUser = UserRepository.shared.getUserById(id: userId) {
                let education = Education(context: context)
                education.edu_id = Int32(eduId)
                education.user_id = Int32(userId)
                education.institution = institution
                education.title = title
                education.start_date = startDate
                education.end_date = endDate
                education.gpa =   gpa
                education.activity = activity
                education.currently_study = currentlyStudy
                education.is_selected = isSelected
                
                educationToUser.addToEducation(education)
                try context.save()
                return true
            }
        }
        catch let error as NSError {
            print(error)
        }
        
        return false
    }
    
    // retrieve education
    func getAllEducation() -> [Education]? {
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
        fetchRequest.predicate = NSPredicate(format: "edu_id == %d", educationId as CVarArg)
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
                          gpa: Float,
                          activity : String,
                          currentlyStudy : Bool,
                          isSelected : Bool) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "edu_id == %d", eduId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Education]
            let education = item?.first
            education?.edu_id = Int32(eduId)
            education?.user_id = Int32(userId)
            education?.title = title
            education?.start_date = startDate
            education?.end_date = endDate
            education?.gpa =  gpa
            education?.activity = activity
            education?.currently_study = currentlyStudy
            education?.is_selected = isSelected
           
            
            try context.save()
            
            return true
        } catch let error as NSError {
            print(error)
        }
        
        return false
    }
    
    func updateSelectedEduStatus(edu_id: Int,
                              isSelected: Bool) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "edu_id == %d", edu_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Education]
            let selectedEdu = item?.first
            selectedEdu?.is_selected = isSelected
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteEducation(data: Education) -> Bool {
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
