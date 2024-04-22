//
//  TextViewMacOSWrapper.swift
//  NotesApp
//
//  Created by DataBunker on 2024-04-18.
//

import SwiftUI

struct TextViewMacOSWrapper: NSViewRepresentable {
    
    let note: Note
    
    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.isEditable = true
        textView.isSelectable = true
        textView.isRichText = true
        textView.allowsUndo = true
        textView.usesInspectorBar = true
        textView.layer?.borderColor = CGColor.init(gray: 1, alpha: 1)
        textView.usesFindPanel = true
        textView.usesFindPanel = true
        textView.usesFontPanel = true
        textView.isRulerVisible = true
        guard let textContainer = textView.textContainer else { return textView }
        textView.frame = textView.layoutManager?.usedRect(for: textContainer) ?? .zero
        return textView
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        
    }
    
    func makeCoordinator() -> () {
        
    }
}

