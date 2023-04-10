//
//  CoreDataProvider.swift
//  FinalPrjPublicHolidaysAPI_CoreData_CustomizedCells_2210573
//
//  Created by macOSBigSur on 2023-04-10.
//

import Foundation
import CoreData

/// Creating my own protocol
protocol CoreDataProviderProtocol {
    func save ( context : NSManagedObjectContext ) -> UUID?
    
    func delete ( context : NSManagedObjectContext ) -> Bool
}

class CoreDataProvider {
    
    // all -> SELECT * FROM;
    // insert/update -> (upsert or save) is the same thing does not matter the name
    // delete
    
    /// creating a function to generate the objectes (NS ManagedObjectContext manage everything)
    static func all(context : NSManagedObjectContext, entityName : String) -> [Any?]{
        
        // create a request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let allObjects = try context.fetch(request)
            return allObjects
        } catch {
            //Toast.ok(view: , title: "Something is wrong!", message: "No data! Try again later!", handler: nil)
            print("EXCEPTION CoreData all method \(error.localizedDescription)")
            return []
        }
    }
    
    /// insert or update mode
    static func save(context : NSManagedObjectContext) throws {
        
        do {
            try context.save()
        } catch {
            
            //Toast.ok(view: , title: "Something is wrong!", message: "Not able to save the data. Try again later!", handler: nil)
            print("EXCEPTION CoreData save method \(error.localizedDescription)")
            throw error
        }
    }
    
    /// delete that returns a bool
    static func delete(context : NSManagedObjectContext, objectToDelete : NSManagedObject) throws -> Bool {
        
        //delete in memory
        context.delete(objectToDelete)
        
        do {
            try context.save()
            return true
        } catch {
            
            //Toast.ok(view: , title: "Something is wrong!", message: "Not able to delete the data. Try again later!", handler: nil)
            print("EXCEPTION CoreData delete method \(error.localizedDescription)")
            throw error
        }
        
        
    }
    
}
