class InMemoryWordDictionary: WordDictionary {
    var words: [String] = []

    func allWords() -> [String] {
        self.words
    }

    func add(words: [String]) {
        self.words.append(contentsOf: words)
    }

    func remove(words: [String]) {
        self.words = self.words.filter({ !words.contains($0) })
    }
}
