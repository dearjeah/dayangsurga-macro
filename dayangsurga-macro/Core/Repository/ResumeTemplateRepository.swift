//
//  ResumeTemplateRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 24/10/21.
//

import Foundation
import UIKit
import CoreData

class ResumeTemplateRepository{
    
    static let shared = ResumeTemplateRepository()
    let entityName = Resume_Template.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createResumeTemplate(template_id: Int,
                              image: Data,
                              name: String){
        do {
            let template = Resume_Template(context: context)
            template.template_id = Int32(template_id)
            template.image = image
            template.name = name
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllTemplate() -> [Resume_Template]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Template]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getTemplateById(id: Int) -> Resume_Template? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "template_id == %@", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Template]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateTemplate(id: Int,
                        newImage: Data,
                        newName: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "template_id == %@", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Template]
            let template = item?.first
            template?.image = newImage
            template?.name = newName
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteUser(data: Resume_Template) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
