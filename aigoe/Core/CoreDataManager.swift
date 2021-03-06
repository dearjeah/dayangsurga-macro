//
//  CoreDataManager.swift
//  dayangsurga-macro
//
//  Created by Delvina Janice on 22/10/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let sharedManager = CoreDataManager(container: CoreDataManager.appScopeContainer())
    
    var persistentContainer: NSPersistentContainer!
    
    //MARK: Init with dependency
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    func setContainer(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    static func appScopeContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: Constants.dataModel)
        container.loadPersistentStores(completionHandler: { (_, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteAllData() {
        
        let storeCoordinator = persistentContainer.persistentStoreCoordinator
        let storeDescription = persistentContainer.persistentStoreDescriptions[0]
        guard let storeURL = storeDescription.url else {
            return
        }
        
        do {
            try storeCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
        } catch {
            return
        }
        
        storeCoordinator.addPersistentStore(with: storeDescription) {
            (_, error) in
            
            if let error = error {
                print("\(error)")
            }
        }
        
        //Reload the data again
        preloadData()
    }
    
    func createUser() {
        let userRepo = UserRepository.shared
        let userId = UUID().uuidString
        userRepo.createUser(user_id: userId, username: "Guest001", email: "", password: "")
        userRepo.currentUserId = userId
        UserDefaults.standard.set(userId, forKey: "currentUserId")
    }
    
}

//MARK: PreloadData
extension CoreDataManager {
    func resetData() {
        CoreDataManager.sharedManager.deleteAllData()
        preloadData()
    }

    func preloadData() {
        if EmptyStateRepository.shared.getAllEmptyState()?.count == 0 {
            preloadEmptyState()
            //PreloadUserData().preloadInitialUser()
        }
        if ResumeTemplateRepository.shared.getAllTemplate()?.count == 0 {
            preloadResumeTemplate()
        }
        
        if PersonalInformationPlaceholderRepository.shared.getAllPIPh()?.count == 0  {
            PreloadUserData().preloadUserPh()
        }
        
        if PersonalInformationSuggestionRepository.shared.getAllPISuggestion()?.count == 0 {
            PreloadUserData().preloadUserSuggession()
        }
        
        if ExperienceSuggestionRepository.shared.getAllExpSuggestion()?.count == 0 {
            preloadExpSuggetsion()
        }
        if ExperiencePlaceholderRepository.shared.getAllExpPh()?.count == 0 {
            preloadExpPh()
        }
        
        if ExpertProfileRepository.shared.getAllExpertProfile()?.count == 0{
            //preloadExpertProfile()
        }
        if AccomplishmentSuggestionRepository.shared.getAllAccomplishmentSuggestion()?.count == 0{
            preloadAccomplishSuggestion()
        }
        if AccomplishmentPlaceholderRepository.shared.getAllAccomplishmentPlaceholder()?.count == 0{
            preloadAccomplishPh()
        }
        
        if EducationPlaceholderRepository.shared.getAllEducationPlaceholder()?.count == 0{
            preloadEduPlaceholder()
            preloadEduSuggestion()
        }
        if QuizRepository.shared.getAllQuiz()?.count == 0 {
            preloadQuiz()
        }
        if SkillPlaceholderRepository.shared.getAllSkillPlaceholder()?.count == 0{
            preloadSkillPh()
            preloadSkillSuggestion()
        }
    }
}
