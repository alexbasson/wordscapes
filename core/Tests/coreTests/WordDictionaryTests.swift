import XCTest
@testable import core

class WordDictionaryTests: XCTestCase {
    func getDictionary() -> WordDictionary? {
        nil
    }

    func testWordDictionaryCanAddWords() {
        if let dictionary = getDictionary() {
            dictionary.add(words: ["word1", "word2"])

            let allWords = dictionary.allWords()

            XCTAssertTrue(allWords.contains("word1"))
            XCTAssertTrue(allWords.contains("word2"))
        }
    }

    func testWordDictionaryCanRemoveWords() {
        if let dictionary = getDictionary() {
            dictionary.add(words: ["word1", "word2"])

            dictionary.remove(words: ["word2"])

            let allWords = dictionary.allWords()

            XCTAssertTrue(allWords.contains("word1"))
            XCTAssertFalse(allWords.contains("word2"))
        }
    }
}

class InMemoryWordDictionaryTests: WordDictionaryTests {
    override func getDictionary() -> WordDictionary {
        return InMemoryWordDictionary()
    }
}

class FileWordDictionaryTests: WordDictionaryTests {
    override func getDictionary() -> WordDictionary? {
        let filename = "testWords.txt"
        let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(filename)
        return FileWordDictionary(fileURL: fileURL)
    }

    override func tearDown() {
        super.tearDown()
        getDictionary()?.remove(words: ["word1", "word2"])
    }
}
