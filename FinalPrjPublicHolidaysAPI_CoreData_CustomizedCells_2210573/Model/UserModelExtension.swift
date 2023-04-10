//
//  UserModelExtension.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by macOSBigSur on 2023-04-10.
//

import Foundation
import CoreData

extension User : CoreDataProviderProtocol {
    
    /// to avoid all the time tipying Book
    static let entityName = "User"
    
    static let NAME_MIN_LENGTH = 6
    static let NAME_MAX_LENGTH = 50
    static let USERNAME_MIN_LENGTH = 8
    static let USERNAME_MAX_LENGTH = 20
    static let PASSWORD_MIN_LENGTH = 8
    static let PASSWORD_MAX_LENGTH = 20
    
    /// We are calling the function all in CoreDataProvider to return all the Users
    static func all(context : NSManagedObjectContext) -> [User] {
        
        /// when we call the method its returns an array of any and we need to cast [User]
        return CoreDataProvider.all(context: context, entityName: entityName) as! [User]
    }
    
    func save(context: NSManagedObjectContext) -> UUID? {
        
        /// the update mode is implicit because the object has already a uuid and the coredata will manage it that should be the same uuid
        if(self.uuid == nil){ // insert mode
            self.uuid = UUID()
        }
        
        do{
            try CoreDataProvider.save(context: context)
            return self.uuid
        } catch {
            return nil
        }
    }
    
    func delete(context: NSManagedObjectContext) -> Bool {
        
        do {
            
            // the function delete is a function for the object that receives the object to delete and it is the self (itself) (who is calling)
            let result = try CoreDataProvider.delete(context: context, objectToDelete: self)
            return result
        } catch {
            return false
        }
    }
    
    
    
    /// find func returns the user if found or nil if not found
    static func find(context : NSManagedObjectContext, username : String) -> User? {
        
        //delete in memory
        let allUsers = all(context: context)
        
        for user in allUsers {
            if(user.username == username){
                return user
            }
        }
        
        return nil
        
    }
    
    
    
    
}
