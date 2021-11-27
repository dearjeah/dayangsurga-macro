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
                             exp_id: [String],
                             edu_id: [String],
                             accom_id: [String],
                             skill_id: [String]){
        do {
            // relation ke resume
            if let getResume = UserResumeRepository.shared.getUserResumeById(resume_id: resume_id){
                let resumeContent = Resume_Content(context: context)
                resumeContent.resume_id = resume_id
                
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
        fetchRequest.predicate = NSPredicate(format: "resume_id == '\(resume_id)'")
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
                             newAccom_id: [String],
                             newSkill_id: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == '\(resume_id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            let newResumeContent = item?.first
            newResumeContent?.exp_id = [newExp_id]
            newResumeContent?.edu_id = [newEdu_id]
            newResumeContent?.accom_id = newAccom_id
            newResumeContent?.skill_id = [newSkill_id]
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateResumeContentEdu(resume_id: String,
                                newEdu_id: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == '\(resume_id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            let newResumeContent = item?.first
            newResumeContent?.edu_id = [newEdu_id]
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateResumeContentExp(resume_id: String,
                                newExp_id: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == '\(resume_id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            let newResumeContent = item?.first
            newResumeContent?.exp_id = [newExp_id]
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateResumeContentSkill(resume_id: String,
                                  newSkill_id: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == '\(resume_id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            let newResumeContent = item?.first
            newResumeContent?.skill_id = [newSkill_id]
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateResumeContentAccomp(resume_id: String,
                                   newAccomp_id: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == '\(resume_id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            let newResumeContent = item?.first
            newResumeContent?.accom_id = [newAccomp_id]
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    // func delete
    func deleteResumeContentEdu(resume_id: String,
                                eduId: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == '\(resume_id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            let resumeContent = item?.first
            let eduIdCount = resumeContent?.edu_id?.count ?? 0
            for i in 0..<eduIdCount {
                if resumeContent?.edu_id?[i] == eduId {
                    resumeContent?.edu_id?.remove(at: i)
                    try context.save()
                    break
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteResumeContentExp(resume_id: String,
                                expId: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == '\(resume_id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            let resumeContent = item?.first
            let expIdCount = resumeContent?.exp_id?.count ?? 0
            for i in 0..<expIdCount {
                if resumeContent?.exp_id?[i] == expId {
                    resumeContent?.edu_id?.remove(at: i)
                    try context.save()
                    break
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteResumeContentSkill(resume_id: String,
                                  skillId: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == '\(resume_id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            let resumeContent = item?.first
            let skillIdCount = resumeContent?.skill_id?.count ?? 0
            for i in 0..<skillIdCount {
                if resumeContent?.skill_id?[i] == skillId {
                    resumeContent?.skill_id?.remove(at: i)
                    try context.save()
                    break
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteResumeContentAccomp(resume_id: String,
                                   accompId: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == '\(resume_id)'")
        do {
            let item = try context.fetch(fetchRequest) as? [Resume_Content]
            let resumeContent = item?.first
            let accomIdCount = resumeContent?.accom_id?.count ?? 0
            for i in 0..<accomIdCount {
                if resumeContent?.accom_id?[i] == accompId {
                    resumeContent?.accom_id?.remove(at: i)
                    try context.save()
                    break
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteResumeContent(data: Resume_Content) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
