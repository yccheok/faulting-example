//
//  CoreDataStack.swift
//  fault
//
//  Created by Yan Cheng Cheok on 22/01/2022.
//

import Foundation
import CoreData

class CoreDataStack {
    static let INSTANCE = CoreDataStack()
    
    private init() {
    }
    
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "fault")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // This is a serious fatal error. We will just simply terminate the app, rather than using error_log.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        // So that when backgroundContext write to persistent store, container.viewContext will retrieve update from
        // persistent store.
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        // TODO: Not sure these are required...
        //
        //container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        //container.viewContext.undoManager = nil
        //container.viewContext.shouldDeleteInaccessibleFaults = true
        
        return container
    }()
    
    private(set) lazy var backgroundContext: NSManagedObjectContext = {
        let backgroundContext = persistentContainer.newBackgroundContext()

        // Similar behavior as Android's Room OnConflictStrategy.REPLACE
        // Old data will be overwritten by new data if index conflicts happen.
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        // TODO: Not sure these are required...
        //backgroundContext.undoManager = nil
        
        return backgroundContext
    }()
}
