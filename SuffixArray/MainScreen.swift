//
//  ContentView.swift
//  SuffixArray
//
//  Created by artembolotov on 20.02.2023.
//

import SwiftUI

struct MainScreen: View {
    @State private var text = "Abracadabra"
    
    @State private var isTextEditPresented = false
    @State private var isResultsPresented = false
    @State private var results = SuffixData(for: "")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text(text)
                            .lineLimit(10)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isTextEditPresented = true
                    }
                } header: {
                    Text("Enter a text for suffix array")
                }
                Section {
                    Button("Create suffix array", action: createSuffixArray)
                        .disabled(text.isEmpty)
                }
            }
            .navigationTitle("Suffix array")
            .sheet(isPresented: $isTextEditPresented) {
                EnterTextScreen(text: $text, isPresented: $isTextEditPresented)
            }
            .sheet(isPresented: $isResultsPresented) {
                SuffixesScreen(suffixData: $results, isPresented: $isResultsPresented)
            }
        }
        
    }
    
    private func createSuffixArray() {
        results = SuffixData(for: text)
        isResultsPresented = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
