//: # Advent of Code - [Day 5](http://adventofcode.com/day/5)
import Foundation

var input = try String(contentsOf:#fileLiteral(resourceName: "input.txt"))
var words = input.components(separatedBy: .newlines)

//: Part one
extension String {
    
    func containsAtLeastThreeVowels() -> Bool {
        return characters.reduce(0) { (cnt, char) -> Int in
            return "aeiou".contains(String(char)) ? cnt + 1 : cnt
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
            if contains(tuple){
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
        for index in startIndex...characters.index(endIndex, offsetBy: -3) {
            let tuple = substring(with: (index ..< <#T##String.CharacterView corresponding to `index`##String.CharacterView#>.index(index, offsetBy: 2)))
            if substring(from: <#T##String.CharacterView corresponding to `index`##String.CharacterView#>.index(index, offsetBy: 2)).contains(tuple) {
                return true
            }
        }
        return false
    }

    func containsRepeatingLetterWithOneInBetween() -> Bool {
        for index in startIndex...characters.index(endIndex, offsetBy: -3) {
            let triple = substring(with: (index ..< <#T##String.CharacterView corresponding to `index`##String.CharacterView#>.index(index, offsetBy: 3)))
            if triple.characters[triple.startIndex] == triple.characters[triple.characters.index(before: triple.endIndex)] {
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
