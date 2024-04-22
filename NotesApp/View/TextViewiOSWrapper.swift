//
//  TextViewiOSWrapper.swift
//  NotesApp
//
//  Created by DataBunker on 2024-04-18.
//

import SwiftUI

struct TextViewiOSWrapper: UIViewRepresentable {
    
    let note: Note
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.allowsEditingTextAttributes = true
        textView.isEditable = true
        textView.isSelectable = true
        textView.font = .systemFont(ofSize: 18)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 5
        textView.textStorage.setAttributedString(note.formattedBody)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.textStorage.setAttributedString(note.formattedBody)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(note: note, parent: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        private let note: Note
        private let parent: TextViewiOSWrapper
        
        init(note: Note, parent: TextViewiOSWrapper) {
            self.note = note
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            note.formattedBody = textView.attributedText
        }
    }
}
