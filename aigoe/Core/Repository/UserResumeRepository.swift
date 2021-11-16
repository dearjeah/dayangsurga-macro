//
//  UserResumeRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 24/10/21.
//

import Foundation
import UIKit
import CoreData

class UserResumeRepository {
    
    static let shared = UserResumeRepository()
    let entityName = User_Resume.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // func create, ini ga tau func nya begimana
    func createUserResume(resume_id: String,
                          template_id: Int,
                          user_id: Int,
                          image: UIImage,
                          name: String,
                          lastUpdate: Date,
                          editingProgress: Int){
        do{
            // relation ke template
            if let getTemplate = ResumeTemplateRepository.shared.getTemplateById(id: template_id){
                let dataUserResume = User_Resume(context: context)
                dataUserResume.resume_id = resume_id
                dataUserResume.image = image.pngData()
                dataUserResume.name = name
                dataUserResume.lastUpdate = lastUpdate
                dataUserResume.editingProgress = Int32(editingProgress)
                
                // relation ke user
                if let getUser = UserRepository.shared.getUserById(id: user_id){
//                    getTemplate.user = getUser
                    getUser.user_id = Int32(user_id)
                    getUser.addToUserResume(dataUserResume)
                }
                
                // relation dari template
                getTemplate.addToUserResume(dataUserResume)
                try context.save()
            }
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllUserResume() -> [User_Resume]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [User_Resume]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    // get data sorting by date
    func getAllUserResumeByDate() -> [User_Resume]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let sort = NSSortDescriptor(key: #keyPath(User_Resume.lastUpdate), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        do {
            let item = try context.fetch(fetchRequest) as? [User_Resume]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getUserResumeById(resume_id: String) -> User_Resume? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == %d", resume_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [User_Resume]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateUserResume(resume_id: String,
                          template_id: Int,
                          user_id: Int,
                          newImage: Data,
                          newName: String,
                          newLastUpdate: Date,
                          newEditingProgress: Int) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == %d", resume_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [User_Resume]
            let newUserResume = item?.first
            newUserResume?.image = newImage
            newUserResume?.name = newName
            newUserResume?.lastUpdate = newLastUpdate
            newUserResume?.editingProgress = Int32(newEditingProgress)
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteUserResume(data: User_Resume) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    // apakah perlu buat func sendiri untuk save editing progress?
    func saveEditingProgress(resume_id: String,
                             page: Int){
        do {
            let editingProgress = User_Resume(context: context)
            editingProgress.resume_id = resume_id
            editingProgress.editingProgress = Int32(page)
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // blm buat validasi pertambahan di tiap page yg 1-5 progress
    func updateEditingProgress(resume_id: Int,
                               newPage: Int){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "resume_id == %d", resume_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [User_Resume]
            let newPages = item?.first
            
            newPages?.editingProgress = Int32(newPage)
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
}
