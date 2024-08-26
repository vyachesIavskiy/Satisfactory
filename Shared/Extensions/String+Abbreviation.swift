
extension String {
    var words: [String] {
        var words = [String]()
        
        enumerateSubstrings(in: (startIndex..<endIndex), options: .byWords) { word, _, _, _ in
            guard let word else { return }
            
            words.append(word)
        }
        
        return words
    }
    
    func abbreviated(_ letterCount: Int = 2) -> String {
        words
            .prefix(letterCount)
            .compactMap { $0.first.map(String.init) }
            .joined()
            .uppercased()
    }
}
