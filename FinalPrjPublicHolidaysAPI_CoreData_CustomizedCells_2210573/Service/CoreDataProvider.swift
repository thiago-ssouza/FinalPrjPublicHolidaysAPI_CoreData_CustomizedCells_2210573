//
//  CoreDataProvider.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by macOSBigSur on 2023-04-10.
//

import Foundation
import CoreData

/**
 * Creating my own protocol
 */
protocol CoreDataProviderProtocol {
    func save ( context : NSManagedObjectContext ) -> UUID?
    
    func delete ( context : NSManagedObjectContext ) -> Bool
}

class CoreDataProvider {
    
    /**
     * Creating a function to generate the objectes (NS ManagedObjectContext manage everything)
     */
    static func all(context : NSManagedObjectContext, entityName : String) -> [Any?]{
        
        // create a request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let allObjects = try context.fetch(request)
            return allObjects
        } catch {
            print("EXCEPTION CoreData all method \(error.localizedDescription)")
            return []
        }
    }
    
    /**
     * Insert or update mode
     */
    static func save(context : NSManagedObjectContext) throws {
        
        do {
            try context.save()
        } catch {
            print("EXCEPTION CoreData save method \(error.localizedDescription)")
            throw error
        }
    }
    
    /**
     * Delete and returns a bool
     */
    static func delete(context : NSManagedObjectContext, objectToDelete : NSManagedObject) throws -> Bool {
        
        //delete in memory
        context.delete(objectToDelete)
        
        do {
            try context.save()
            return true
        } catch {
            print("EXCEPTION CoreData delete method \(error.localizedDescription)")
            throw error
        }
        
        
    }
    
}
