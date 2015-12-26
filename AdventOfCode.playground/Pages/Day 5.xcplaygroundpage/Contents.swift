//: # Advent of Code - [Day 5](http://adventofcode.com/day/5)
import Foundation

var input = try String(contentsOfURL:[#FileReference(fileReferenceLiteral: "input.txt")#])
var words = input.componentsSeparatedByCharactersInSet(.newlineCharacterSet())

//: Part one
extension String {
    
    func containsAtLeastThreeVowels() -> Bool {
        return characters.reduce(0) { (cnt, char) -> Int in
            return "aeiou".containsString(String(char)) ? cnt + 1 : cnt
        } > 2
    }
    
    func containsDoubleCharacters() -> Bool {
        var previous : Character?
        for c in characters {
            if c == previous {
                return true
            }
            previous = c
        }
        return false
    }
    
    func containsIllegalTuples() -> Bool {
        for tuple in ["ab", "cd", "pq", "xy"] {
            if containsString(tuple){
                return true
            }
        }
        return false
    }
    
    func isNice() -> Bool {
        return containsAtLeastThreeVowels()
            && containsDoubleCharacters()
            && !containsIllegalTuples()
    }
}

words.reduce(0) { (cnt, word) -> Int in
    return word.isNice() ? cnt + 1 : cnt
}

//: Part two
extension String {
    
    func containsDoubleNonOverlappingTwoCharacters() -> Bool {

        if characters.count < 4 {
            return false
        }
        for index in startIndex...endIndex.advancedBy(-3) {
            let tuple = substringWithRange(Range<String.Index>(start: index, end: index.advancedBy(2)))
            if substringFromIndex(index.advancedBy(2)).containsString(tuple) {
                return true
            }
        }
        return false
    }

    func containsRepeatingLetterWithOneInBetween() -> Bool {
        for index in startIndex...endIndex.advancedBy(-3) {
            let triple = substringWithRange(Range<String.Index>(start: index, end: index.advancedBy(3)))
            if triple.characters[triple.startIndex] == triple.characters[triple.endIndex.predecessor()] {
                return true
            }
        }
        return false
    }
    
    func isReallyNice() -> Bool {
        return containsDoubleNonOverlappingTwoCharacters()
            && containsRepeatingLetterWithOneInBetween()
    }
}

words.reduce(0) { (cnt, word) -> Int in
    return word.isReallyNice() ? cnt + 1 : cnt
}
