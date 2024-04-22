//
//  NSPredicate+Helper.swift
//  NotesApp
//
//  Created by DataBunker on 2024-04-14.
//

import Foundation

extension NSPredicate {
    static let all = NSPredicate(format: "TRUEPREDICATE")
    static let none = NSPredicate(format: "FALSEPREDICATE")
}
