#!/usr/bin/swift

import Cocoa

extension String {
    func numberOfOccurrences(of char: Character) -> Int {
        return self.filter { $0 == char }.count
    }

    func containsOnly(these letters: String) -> Bool {
        return self.allSatisfy { char in letters.contains(char) }
    }

    func containsNoMoreOccurrences(of char: Character, thanDoes letters: String) -> Bool {
        return self.numberOfOccurrences(of: char) <= letters.numberOfOccurrences(of: char)
    }

    func length(isAtLeast minLength: Int, andAtMost maxLength: Int) -> Bool {
        return (self.count >= minLength) && (self.count <= maxLength)
    }
}

let filename = "words.txt"
let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(filename)

var words: [String] = []
do {
    let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
    words = fileContents.components(separatedBy: "\n")
}
catch {}

print("Allow three-letter words? Y/N")
let minWordLength = (readLine()?.lowercased().contains("y") ?? true) ? 3 : 4

print("Enter letters (enter a blank line when done):")
var letters = ""
while let line = readLine(), line.count > 0 {
    letters.append(line.lowercased())
}

let filteredWords = words
    .filter({ word in return word.length(isAtLeast: minWordLength, andAtMost: letters.count) })
    .filter({ word in return word.containsOnly(these: letters) })
    .filter({ word in return word.allSatisfy { char in word.containsNoMoreOccurrences(of: char, thanDoes: letters) } })

if (filteredWords.count > 0) {
    print("Found words:")
    for word in filteredWords {
        print(word)
    }
} else {
    print("No words match these letters")
}
