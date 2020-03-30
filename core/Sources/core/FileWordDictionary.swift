import Cocoa

class FileWordDictionary: WordDictionary {
    let fileURL: URL

    init(fileURL: URL) {
        self.fileURL = fileURL
    }

    func allWords() -> [String] {
        do {
            let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
            return fileContents.components(separatedBy: "\n")
        }
        catch {}
        return []
    }

    func add(words: [String]) {
        writeToFile(words: allWords() + words)
    }

    func remove(words: [String]) {
        writeToFile(words: allWords().filter({ word in !words.contains(word) }))
    }

    private func writeToFile(words: [String]) {
        var joinedString = words
            .filter({ $0.nonEmpty() })
            .sorted(by: { $0 < $1 })
            .joined(separator: "\n")

        joinedString.append("\n")

        do {
            try joinedString.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {}
    }
}

extension String {
    func nonEmpty() -> Bool {
        self.count > 0
    }
}
