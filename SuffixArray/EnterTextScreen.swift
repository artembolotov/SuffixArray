//
//  EnterTextView.swift
//  SuffixArray
//
//  Created by artembolotov on 20.02.2023.
//

import SwiftUI

struct EnterTextScreen: View {
    @Binding var text: String
    @Binding var isPresented: Bool
    @State private var isFirstResponder = true
    
    var body: some View {
        NavigationView {
            GeometryReader { _ in
                LegacyTextView(text: $text, isFirstResponder: $isFirstResponder) { textView in
                    textView.font = .systemFont(ofSize: UIFont.labelFontSize)
                    textView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
                }
            }
            .ignoresSafeArea(.keyboard, edges: isFirstResponder ? .top : .bottom)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: closeView)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear", action: clearText)
                        .disabled(text.isEmpty)
                }
            }
            .navigationTitle("Enter text")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    private func closeView() {
        isPresented = false
    }
    
    private func clearText() {
        text = ""
    }
}

struct EnterTextView_Previews: PreviewProvider {
    static var previews: some View {
        EnterTextScreen(text: .constant("Some text"), isPresented: .constant(true))
    }
}
