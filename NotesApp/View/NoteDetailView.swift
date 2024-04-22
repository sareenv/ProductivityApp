//
//  NoteDetailView.swift
//  NotesApp
//
//  Created by DataBunker on 2024-04-14.
//

import SwiftUI

struct NoteDetailView: View {
    
    /// A note required for the detail view.
    @ObservedObject var note: Note
    
    @State var status: Status = .draft
    
    // MARK: - View Conformance.
    var body: some View {
        return VStack(spacing: 20) {
            
            Text("Note")
                .font(.title)
            HStack {
                Text("Note Title: ")
                Text(note.title)
            }
            
            TextField("title", text: $note.title)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Picker(selection: $note.status) {
                ForEach(Status.allCases) { status in
                    Text(status.rawValue)
                        .tag(status)
                }
            } label: {
                Text("Notes Status")
            }.pickerStyle(.segmented)
            
            #if os(iOS)
            TextViewiOSWrapper(note: note)
            #else
            TextViewMacOSWrapper(note: note)
            #endif
            
            Button("Delete Note") {
                let context = note.managedObjectContext
                context?.delete(note)
            }
            .foregroundStyle(.pink)
            
            Button("clear title") {
                note.title = ""
            }
        }
        .padding(.horizontal)
        .onDisappear {
            // when the view is leaving.
            PersistenceController.shared.save()
        }
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let note = Note(title: "New note",
                        creationDate: Date(),
                        context: context)
        NoteDetailView(note: note)
    }
}
