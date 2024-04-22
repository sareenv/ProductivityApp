//
//  Note+Helper.swift
//  NotesApp
//
//  Created by DataBunker on 2024-04-14.
//

import CoreData

extension Note {
    
    var title: String {
        get {
            self.title_ ?? ""
        } set  {
            self.title_ = newValue
        }
    }
    
    var status: Status {
        get {
            if let rawStatus = status_,
                let status = Status(rawValue: rawStatus) {
                 return status
            } else {
                return Status.draft
            }
        } set {
            status_ = newValue.rawValue
        }
    }
    
    var formattedBody: NSAttributedString {
        get {
            NSAttributedString()
        } set {
            
        }
    }
    
    convenience init(title: String,
                     creationDate: Date = Date(),
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.creationDate = creationDate
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<Note> {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Note.creationDate, ascending: true)]
        request.predicate = predicate
        return request
    }
}
