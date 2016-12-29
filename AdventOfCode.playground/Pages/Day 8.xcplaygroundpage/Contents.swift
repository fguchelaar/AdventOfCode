//: # Advent of Code - [Day 8](http://adventofcode.com/day/8)
import Foundation

var input = try String(contentsOf:#fileLiteral(resourceName: "input.txt"))
var lines = input.components(separatedBy: .whitespacesAndNewlines)

var codeLength = 0
var valueLength = 0

for line in lines {
    codeLength += line.lengthOfBytes(using: String.Encoding.utf8)

    let trimmed = line.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
    let strippedDoubleBackslash = trimmed.replacingOccurrences(of: "\\\\", with: "|")
    let strippedQuotes = strippedDoubleBackslash.replacingOccurrences(of: "\\\"", with: "_")

    var strippedHex = strippedQuotes
    var hexRange = strippedQuotes.range(of: "\\x")
    while (hexRange != nil) {
        strippedHex.replaceSubrange((hexRange!.lowerBound ..< <#T##Collection corresponding to your index##Collection#>.index(hexRange!.lowerBound, offsetBy: 4)), with:"+")
        hexRange = strippedHex.range(of: "\\x")
    }
    
    valueLength += strippedHex.lengthOfBytes(using: String.Encoding.utf8)
}

print(codeLength - valueLength)

var encodedLength = 0
var originalLength = 0

for line in lines {
    originalLength += line.lengthOfBytes(using: String.Encoding.utf8)
    
    let enc1 = line.replacingOccurrences(of: "\\", with: "\\\\")
    let enc2 = enc1.replacingOccurrences(of: "\"", with: "\\\"")
    let encoded = "\"\(enc2)\""
    encodedLength += encoded.lengthOfBytes(using: String.Encoding.utf8)
}

print(encodedLength - originalLength)
