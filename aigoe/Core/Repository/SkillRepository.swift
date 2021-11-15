//
//  SkillRepository.swift
//  dayangsurga-macro
//
//  Created by Anya Akbar on 03/11/21.
//


import Foundation
import UIKit
import CoreData

class SkillRepository{
    
    static let shared = SkillRepository()
    let entityName = Skills.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createSkill(       skillId: Int32,
                             userId: Int32,
                             skillName: String,
                             isSelected : Bool)-> Bool{
        do {
            // relation accomplishment-user
            if let SkillToUser = UserRepository.shared.getUserById(id: Int(userId)) {
                let skill = Skills(context: context)
                skill.skill_id = skillId
                skill.user_id = userId
                skill.skill_name = skillName
                skill.is_selected = isSelected
                
                SkillToUser.addToSkill(skill)
                try context.save()
                return true
            }
        }
        catch let error as NSError {
            print(error)
        }
        return false
    }
    
    // retrieve skill
    func getAllSkill() -> [Skills]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Skills]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getSkillsById(skillId: Int32) -> Skills? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "skill_id == %d", skillId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Skills]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateSkill( skillId: Int,
                      userId: Int,
                      skillName: String,
                      isSelected : Bool)-> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "skill_id == %d", skillId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Skills]
            let skill = item?.first
            skill?.skill_id = Int32(skillId)
            skill?.user_id = Int32(userId)
            skill?.skill_name = skillName
            skill?.is_selected = isSelected
         
            try context.save()
            return true
        } catch let error as NSError {
            print(error)
        }
        return false
    }
    
    func updateSelectedSkillStatus(skill_id: Int,
                              isSelected: Bool) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "skill_id == %d", skill_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Skills]
            let newSkill = item?.first
            newSkill?.is_selected = isSelected
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    // func delete
    func deleteSkills(data: Skills) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}

