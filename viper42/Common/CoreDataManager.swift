//
//  CoreDataManager.swift
//  viper42
//
//  Created by Udo von Eynern on 05.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    
    private init() {} // Prevent clients from creating another instance.
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "viper42")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func getItems<T : NSManagedObject>(predicate : NSPredicate? = nil) -> [T]{
        do {
            let reqest = T.fetchRequest()
            reqest.predicate = predicate
            if let items = try persistentContainer.viewContext.fetch(reqest) as? [T] {
                return items
            } else {
                return [T]()
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return [T]()
        }
    }
    
    func getObjectBy<T : NSManagedObject>(id : NSManagedObjectID) -> T? {
        if let object = try? persistentContainer.viewContext.existingObject(with: id) as? T {
            return object
        }
        else {
            return nil
        }
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
}
