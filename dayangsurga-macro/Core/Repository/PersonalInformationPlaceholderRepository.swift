//
//  UserPlaceholderRepository.swift
//  dayangsurga-macro
//
//  Created by Olivia Dwi  Susanti on 24/10/21.
//

import Foundation
import UIKit
import CoreData

class PersonalInformationPlaceholderRepository{
    
    static let shared = PersonalInformationPlaceholderRepository()
    let entityName = PersonalInformation_Placeholder.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    // create data
    func createUserPh(pi_ph_id: Int,
                      user_id: Int,
                      name_ph: String,
                      phoneNumber_ph: String,
                      email_ph: String,
                      address_ph: String,
                      summary_ph: String){
        do {
//MARK: Removing user relation because there's no user yet. So core data can't catch it - anya
//            if let getUser = UserRepository.shared.getUserById(id: user_id){
                let piPlaceholder = PersonalInformation_Placeholder(context: context)
                piPlaceholder.pi_ph_id = Int32(pi_ph_id)
                piPlaceholder.user_id = Int32(user_id)
                piPlaceholder.name_ph = name_ph
                piPlaceholder.phoneNumber_ph = phoneNumber_ph
                piPlaceholder.email_ph = email_ph
                piPlaceholder.address_ph = address_ph
                piPlaceholder.summary_ph = summary_ph
                
//                piPlaceholder.user = getUser
                try context.save()
//            }
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    // retrieve
    func getAllPIPh() -> [PersonalInformation_Placeholder]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let item = try context.fetch(fetchRequest) as? [PersonalInformation_Placeholder]
            return item
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func getPIPhById(pi_ph_id: Int) -> PersonalInformation_Placeholder? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "pi_ph_id == %d", pi_ph_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [PersonalInformation_Placeholder]
            return item?.first
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    // func updates
    func updatePIPh(pi_ph_id: Int,
                    user_id: Int,
                    newName_ph: String,
                    newPhoneNumber_ph: String,
                    newEmail_ph: String,
                    newAddress_ph: String,
                    newSummary_ph: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "pi_ph_id == %d", pi_ph_id as CVarArg)
        do {
            let item = try context.fetch(fetchRequest) as? [PersonalInformation_Placeholder]
            let piPlaceholder = item?.first
            
            piPlaceholder?.name_ph = newName_ph
            piPlaceholder?.phoneNumber_ph = newPhoneNumber_ph
            piPlaceholder?.email_ph = newEmail_ph
            piPlaceholder?.address_ph = newEmail_ph
            piPlaceholder?.summary_ph = newSummary_ph
            
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    // func delete
    func deletePIPh(data: PersonalInformation_Placeholder) {
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
}
