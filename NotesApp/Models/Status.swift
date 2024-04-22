//
//  Status.swift
//  NotesApp
//
//  Created by DataBunker on 2024-04-18.
//

import Foundation

enum Status: String, Identifiable, CaseIterable {
    var id: String {
        return self.rawValue
    }
    case draft = "Draft"
    case review = "Review"
    case archived = "Archived"
}
