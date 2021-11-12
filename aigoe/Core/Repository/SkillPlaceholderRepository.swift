//
//  SkillPlaceholderRepository.swift
//  dayangsurga-macro
//
//  Created by Anya Akbar on 03/11/21.
//

import Foundation
import UIKit
import CoreData

class SkillPlaceholderRepository{
    
    static let shared = SkillPlaceholderRepository()
    let entityName = Skills_Placeholder.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create
    func createSkillPlaceholder(skillId: Int32,
                                skillPlaceholderId: Int,
                                skillPlaceholderName: String){
        do {
            let skillPlaceholder = Skills_Placeholder(context: context)
            skillPlaceholder.skills_id = Int32(skillId)
            skillPlaceholder.skills_ph_id = Int32(skillPlaceholderId)
            skillPlaceholder.skills_name_ph = skillPlaceholderName
            
            // relation (one-to-one)
            if let skillItem = SkillRepository.shared.getSkillsById(skillId: skillId){
                skillPlaceholder.skills = skillItem
            }
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllSkillPlaceholder() -> [Skills_Placeholder]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Skills_Placeholder]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getSkillPlaceholderById(id: Int) -> Skills_Placeholder? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "skills_ph_id == %d", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Skills_Placeholder]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateSkillPlaceholder(skillId: Int,
                                skillPlaceholderId: Int,
                                skillPlaceholderName: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "exp_ph_id == %d", skillPlaceholderId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Skills_Placeholder]
            let skillPlaceholder = item?.first
            
            skillPlaceholder?.skills_id = Int32(skillId)
            skillPlaceholder?.skills_ph_id = Int32(skillPlaceholderId)
            skillPlaceholder?.skills_name_ph = skillPlaceholderName
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteSkillPlacheholder(data: Skills_Placeholder) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
