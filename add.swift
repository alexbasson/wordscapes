#!/usr/bin/swift

import Cocoa

let filename = "words.txt"
let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(filename)

var words: [String] = []
do {
    let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
    words = fileContents.components(separatedBy: "\n")
} catch {
}

print("Enter words to add dictionary (enter a blank line when done):")
var wordsToAdd: [String] = []
while let line = readLine(), line.count > 0 {
    wordsToAdd.append(line.lowercased())
}

words.append(contentsOf: wordsToAdd)

let joinedString = words
    .filter({ $0.count > 0 })
    .sorted(by: { $0 < $1 })
    .joined(separator: "\n")

do {
    try "\(joinedString)\n".write(to: fileURL, atomically: false, encoding: .utf8)
} catch {
}
