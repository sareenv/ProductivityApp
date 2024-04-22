//
//  Persistence.swift
//  NotesApp
//
//  Created by DataBunker on 2024-04-14.
//

import CoreData

/// A singleton class to create and manage the data files locally.
struct PersistenceController {
    /// Shared instance for this class.
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        /// A container with the name of the application.
        container = NSPersistentContainer(name: "NotesApp")
        
        /// Load locally and acts as the mock.
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /// A crash if the loading is failed and crashing the application.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save() {
        let context = container.viewContext
        guard context.hasChanges else { return }
        DispatchQueue.global(qos: .background).async {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                // Never leave this for the production
                fatalError(nsError.localizedDescription)
            }
        }
    }
        
    // MARK: - A preview for presistence controller.
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newNote = Note(title: "title", context: viewContext)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
