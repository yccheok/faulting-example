//
//  ViewController.swift
//  fault
//
//  Created by Yan Cheng Cheok on 22/01/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    private lazy var fetchedResultsController: NSFetchedResultsController<Note> = {
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        // We will NOT fetch "heavy_body" explicitly during app start, because it is a heavy resource.
        fetchRequest.propertiesToFetch = [
            "lite_title"
        ]
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "lite_title", ascending: false)
        ]
        
        // Create a fetched results controller and set its fetch request, context, and delegate.
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataStack.INSTANCE.persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        controller.delegate = self
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Connect to fetch result controller
        do {
            try fetchedResultsController.performFetch()
        } catch {
            error_log(error)
        }
    }

    
    @IBAction func writeData(_ sender: Any) {
        NoteRepository.INSTANCE.save(lite_title: "the title", heavy_body: "the body, which is a heavy resource")
        
        print("Write Data. (Please restart the app then proceed with Read Data testing)")
    }
    
    @IBAction func readData(_ sender: Any) {
        guard let sections = self.fetchedResultsController.sections else { return }
        
        guard let note = sections[0].objects?[0] as? Note else { return }
        
        if note.isFault {
            print(">>>> This is a fault.\n")
        } else {
            print(">>>> This is NOT a fault.\n")
        }
        
        print(">>>> Read lite_title\n")
        
        let lite_title = note.lite_title
        
        print(">>>> After accessing lite_title, isFault is \(note.isFault)\n")
        
        print(">>>> Read heavy_body\n")
        
        let heavy_body = note.heavy_body
        
        print(">>>> After accessing heavy_body, isFault is \(note.isFault)\n")
        
        // Move the object back to fault.
        note.managedObjectContext?.refresh(note, mergeChanges: false)
        
        print(">>>> After moving object back to fault, isFault is \(note.isFault)\n")
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
    
}

