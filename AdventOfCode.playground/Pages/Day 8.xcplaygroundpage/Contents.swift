//: # Advent of Code - [Day 8](http://adventofcode.com/day/8)
import Foundation

var input = try String(contentsOfURL:[#FileReference(fileReferenceLiteral: "input.txt")#])
var lines = input.componentsSeparatedByCharactersInSet(.whitespaceAndNewlineCharacterSet())

var codeLength = 0
var valueLength = 0

for line in lines {
    codeLength += line.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)

    let trimmed = line.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "\""))
    let strippedDoubleBackslash = trimmed.stringByReplacingOccurrencesOfString("\\\\", withString: "|")
    let strippedQuotes = strippedDoubleBackslash.stringByReplacingOccurrencesOfString("\\\"", withString: "_")

    var strippedHex = strippedQuotes
    var hexRange = strippedQuotes.rangeOfString("\\x")
    while (hexRange != nil) {
        strippedHex.replaceRange(Range<String.Index>(start: hexRange!.startIndex, end: hexRange!.startIndex.advancedBy(4)), with:"+")
        hexRange = strippedHex.rangeOfString("\\x")
    }
    
    valueLength += strippedHex.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
}

print(codeLength - valueLength)

var encodedLength = 0
var originalLength = 0

for line in lines {
    originalLength += line.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    
    let enc1 = line.stringByReplacingOccurrencesOfString("\\", withString: "\\\\")
    let enc2 = enc1.stringByReplacingOccurrencesOfString("\"", withString: "\\\"")
    let encoded = "\"\(enc2)\""
    encodedLength += encoded.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
}

print(encodedLength - originalLength)
