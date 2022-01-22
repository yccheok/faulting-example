//
//  NoteRepository.swift
//  fault
//
//  Created by Yan Cheng Cheok on 22/01/2022.
//

import CoreData

class NoteRepository {
    static let INSTANCE = NoteRepository()
    
    private init() {
    }
    
    func getNote() -> Note? {
        let coreDataStack = CoreDataStack.INSTANCE
        let viewContext = coreDataStack.persistentContainer.viewContext
        var result: Note? = nil
        
        viewContext.performAndWait {
            let fetchRequest = Note.fetchRequest()
            do {
                let note = try fetchRequest.execute()
                let count = note.count
                precondition(count == 0 || count == 1)
                result = note.first
            } catch {
                error_log(error)
            }
        }

        return result
    }
    
    func save(lite_title: String, heavy_body: String) {
        let coreDataStack = CoreDataStack.INSTANCE
        let backgroundContext = coreDataStack.backgroundContext
        
        backgroundContext.performAndWait {
            let _ = Note(context: backgroundContext, lite_title: lite_title, heavy_body: heavy_body)
            saveContextIfPossible(backgroundContext)
        }
    }
    
    private func saveContextIfPossible(_ context: NSManagedObjectContext) {
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
