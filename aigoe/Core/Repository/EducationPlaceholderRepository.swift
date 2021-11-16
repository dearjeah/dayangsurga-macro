//
//  EducationPlaceholderRepository.swift
//  dayangsurga-macro
//
//  Created by Anya Akbar on 03/11/21.
//

import Foundation
import UIKit
import CoreData

class EducationPlaceholderRepository{
    
    static let shared = EducationPlaceholderRepository()
    let entityName = Edu_Placeholder.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create
    func createEducationPlaceholder(eduId: String,
                                    eduPlaceholderId:Int,
                                    institutionPlaceholder: String,
                                    titlePlaceholder: String,
                                    gpaPlaceholder : String,
                                    activityPlaceholder: String,
                                    startDatePlaceholder : String,
                                    endDatePlaceholder : String
                                    ){
        do {
            let educationPlaceholder = Edu_Placeholder(context: context)
            educationPlaceholder.edu_id = eduId
            educationPlaceholder.edu_ph_id = Int32(eduPlaceholderId)
            educationPlaceholder.institution_ph = institutionPlaceholder
            educationPlaceholder.title_ph = titlePlaceholder
            educationPlaceholder.gpa_ph = gpaPlaceholder
            educationPlaceholder.activity_ph = activityPlaceholder
            educationPlaceholder.start_date_ph = startDatePlaceholder
            educationPlaceholder.end_date_ph = endDatePlaceholder
            
            // relation (one-to-one)
            if let educationItem = EducationRepository.shared.getEducationById(educationId: eduId){
                educationPlaceholder.education = educationItem
            }
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllEducationPlaceholder() -> [Edu_Placeholder]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Edu_Placeholder]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getEducationPlaceholderById(id: Int) -> Edu_Placeholder? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "edu_ph_id == %d", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Edu_Placeholder]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateEducationPlaceholder(eduId: Int,
                                    eduPlaceholderId:Int,
                                    institutionPlaceholder: String,
                                    titlePlaceholder: String,
                                    gpaPlaceholder : String,
                                    activityPlaceholder: String,
                                    startDatePlaceholder : String,
                                    endDatePlaceholder : String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "edu_ph_id == %d", eduId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Edu_Placeholder]
            let educationPlaceholder = item?.first
            
            educationPlaceholder?.institution_ph = institutionPlaceholder
            educationPlaceholder?.title_ph = titlePlaceholder
            educationPlaceholder?.gpa_ph = gpaPlaceholder
            educationPlaceholder?.activity_ph = activityPlaceholder
            educationPlaceholder?.start_date_ph = startDatePlaceholder
            educationPlaceholder?.end_date_ph = endDatePlaceholder
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteEducationPlacheholder(data: Edu_Placeholder) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
