//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by DataBunker on 2024-04-14.
//

import SwiftUI

@main
struct NotesAppApp: App {
    
    /// A shared singleton instance.
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            /// injecting the view context to the main view.
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
                case .active: print("app became active")
                case .inactive: print("app became inactive")
                case .background:
                    /// Saves the data for the pwesistence when the application goes into the background mode.
                    persistenceController.save()
            // not currently but maybe added something in the future for swift.
            @unknown default:
                print("app phases added unknown case")
            }
        }
        .commands {
            CommandGroup(replacing: .saveItem) {
                Button("Save") {
                    persistenceController.save()
                }
                .keyboardShortcut("S", modifiers: [.command])
            }
        }
    }
}
