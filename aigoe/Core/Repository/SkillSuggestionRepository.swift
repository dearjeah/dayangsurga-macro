//
//  SkillSuggestionRepository.swift
//  dayangsurga-macro
//
//  Created by Anya Akbar on 03/11/21.
//


import Foundation
import UIKit
import CoreData

class SkillSuggestionRepository{
    
    static let shared = SkillSuggestionRepository()
    let entityName = Skills_Suggest.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createSkillSuggestion(skillId: String,
                               skillSuggestionId: Int32,
                               skillSuggest: String){
        do {
            let skillSuggestion = Skills_Suggest(context: context)
            skillSuggestion.skills_id = skillId
            skillSuggestion.skills_suggest_id = skillSuggestionId
            skillSuggestion.skills_suggest = skillSuggest
            
            // relation (one-to-one)
            if let skillItem = SkillRepository.shared.getSkillsById(skillId: skillId){
                skillSuggestion.skills = skillItem
            }
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllSkillSuggestion() -> [Skills_Suggest]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Skills_Suggest]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getSkillSuggestionById(skill_suggestion_id: Int) -> Skills_Suggest? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "skills_suggest_id == %d", skill_suggestion_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Skills_Suggest]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateExpSuggestion(skillId: Int32,
                             skillSuggestionId: Int32,
                             skillSuggest: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "skill_suggest_id == %d", skillSuggestionId as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Skills_Suggest]
            let skillSuggestItem = item?.first
            skillSuggestItem?.skills_suggest = skillSuggest
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteSkillSuggestion(data: Skills_Suggest) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
