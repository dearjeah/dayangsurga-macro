//
//  ResumeContentRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 24/10/21.
//

import Foundation
import UIKit
import CoreData

class ResumeContentRepository{
    
    static let shared = ResumeContentRepository()
    let entityName = Resume_Content.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createResumeContent(resume_id: String,
                             exp_id: String,
                             edu_id: String,
                             accom_id: String,
                             skill_id: String){
        do {
            // relation ke resume
            if let getResume = UserResumeRepository.shared.getUserResumeById(resume_id: resume_id){
                let resumeContent = Resume_Content(context: context)
                resumeContent.resume_id = resume_id
                
                // relation ke experience
                if let getExp = ExperienceRepository.shared.getExperienceById(experienceId: exp_id){
                    getExp.exp_id = exp_id
                    getExp.addToResumeContent(resumeContent)
                }
                
                // relation dari template
                getResume.addToResumeContent(resumeContent)
                try context.save()
            }
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllResumeContent() -> [Resume_Content]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getResumeContentById(resume_id: String) -> Resume_Content? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == %d", resume_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateResumeContent(resume_id: String,
                             newExp_id: String,
                             newEdu_id: String,
                             newAccom_id: String,
                             newSkill_id: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == %d", resume_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            let newResumeContent = item?.first
            newResumeContent?.exp_id = newExp_id
            newResumeContent?.edu_id = newEdu_id
            newResumeContent?.accom_id = newAccom_id
            newResumeContent?.skill_id = newSkill_id
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    // func delete
    func deleteUser(data: Resume_Content) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
