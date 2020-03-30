import Cocoa

protocol WordDictionary {
    func allWords() -> [String]
    func add(words: [String])
    func remove(words: [String])
}
