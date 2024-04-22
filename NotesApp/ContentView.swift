//
//  ContentView.swift
//  NotesApp
//
//  Created by DataBunker on 2024-04-14.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    /// A property wrapper to fetch the data.
    @FetchRequest(fetchRequest: Note.fetch())
    private var notes: FetchedResults<Note>

    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NavigationLink {
                        NoteDetailView(note: note)
                    } label: {
                        Text(note.creationDate!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addNote) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addNote() {
        _ = Note(title: "New Title", creationDate: Date(), context: viewContext)
    }

    private func deleteItems(offsets: IndexSet) {
        offsets.map { notes[$0] }.forEach(viewContext.delete)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
