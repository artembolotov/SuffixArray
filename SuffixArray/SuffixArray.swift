//
//  SuffixArray.swift
//  SuffixArray
//
//  Created by artembolotov on 22.02.2023.
//

import Foundation

struct SuffixArray: Sequence {
    let string: String
    
    init(_ string: String) {
        self.string = string
    }
    
    func makeIterator() -> SuffixIterator {
        return SuffixIterator(string)
    }
}

struct SuffixIterator: IteratorProtocol {
    var current: String.SubSequence?
    init(_ string: String) {
        self.current = string.lowercased().suffix(from: string.startIndex)
    }

    mutating func next() -> String.SubSequence? {
        guard let thisCurrent = current,
                thisCurrent.count > 0 else { return nil }
        let index = thisCurrent.index(thisCurrent.startIndex, offsetBy: 1)
        current = thisCurrent.suffix(from: index)
        return thisCurrent
    }
}

final class SuffixData {
    let suffixes: [String]
    let counts: [String: Int]
    let topTriads: [String]
    
    init(for text: String) {
        let suffixArray = SuffixData.suffixArray(for: text)
        
        var counts = [String: Int]()
        
        suffixArray.forEach { suffix in
            let strSuffix = String(suffix)
            let count = counts[strSuffix] ?? 0
            counts[strSuffix] = count + 1
        }
        
        self.counts = counts
        self.suffixes = counts.keys.sorted()
        self.topTriads = counts.filter { $0.key.count == 3 }.sorted { $0.value > $1.value }.prefix(10).map { String($0.key) }
    }
    
    private static func suffixArray(for text: String) -> [Substring] {
        let separators = CharacterSet.whitespaces.union(.punctuationCharacters)
        let words = text.components(separatedBy: separators).filter { !$0.isEmpty }
        
        return words.reduce(into: []) { partialResult, word in
            partialResult += SuffixArray(word)
        }
    }
}
