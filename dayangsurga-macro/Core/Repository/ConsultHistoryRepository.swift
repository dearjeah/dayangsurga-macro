//
//  ConsultHistoryRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 25/10/21.
//

import Foundation
import UIKit
import CoreData

class ConsultHistoryRepository{
    
    static let shared = ConsultHistoryRepository()
    let entityName = Consult_History.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createConsultHistory(expert_id: Int,
                              user_id: Int,
                              date: Date){
        do {
            if let getUser = UserRepository.shared.getUserById(id: user_id) {
                let consult = Consult_History(context: context)
                consult.expert_id = Int32(expert_id)
                consult.user_id = Int32(user_id)
                consult.date = date
                
                getUser.addToConsultHistory(consult)
                try context.save()
            }
        }
        catch let error as NSError {
            print(error)
        }
    }

    // retrieve
    func getConsultHistory() -> [Consult_History]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [Consult_History]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getConsultHistoryById(id: Int) -> Consult_History? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "expert_id == %@", id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Consult_History]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updateConsultHistory(expert_id: Int,
                              user_id: Int,
                              newDate: Date) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "expert_id == %@", expert_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [Consult_History]
            let newHistory = item?.first
            newHistory?.date = newDate
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deleteUser(data: Consult_History) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}


