//
//  EmptyStateRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 24/10/21.
//

import Foundation
import UIKit
import CoreData

class EmptyStateRepository{
    
    static let shared = EmptyStateRepository()
    let entityName = Empty_State.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createEmptyState(emptyState_id: Int,
                              image: Data,
                              title: String){
        do {
            let emptyState = Empty_State(context: context)
            emptyState.emptyState_id = Int32(emptyState_id)
            emptyState.image = image
            emptyState.title = title
            
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllEmptyState() -> [Empty_State]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Empty_State]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getEmptyStateById(id: Int) -> Empty_State? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "emptyState_id == %@", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Empty_State]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateEmptyState(id: Int,
                          newImage: Data,
                          newTitle: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "emptyState_id == %@", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Empty_State]
            let emptyState = item?.first
            
            emptyState?.image = newImage
            emptyState?.title = newTitle
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteUser(data: Empty_State) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}

