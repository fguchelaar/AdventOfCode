////: # Advent of Code - [Day 11](http://adventofcode.com/day/11)
import Foundation

var input = "hxbxxyzz"

extension String {
    
    func next() -> String {
        
        var shouldIncrement = true
        var scalars = String.UnicodeScalarView()
        
        for c in unicodeScalars.reverse() {
            if (shouldIncrement) {
                var newValue = c.value >= 122 ? 97 : c.value + UInt32(1)
                
                if newValue == 105 || newValue == 108 || newValue == 111 {
                    newValue++
                }
                
                scalars.append(UnicodeScalar(newValue))
                shouldIncrement = newValue == 97
            }
            else {
                scalars.append(c)
            }
        }
        if (shouldIncrement) {
            return "aaaaaaaa"
        }
        return String(String(scalars).characters.reverse())
        
    }
    
    func containsStraight() -> Bool {
        for index in unicodeScalars.startIndex...unicodeScalars.endIndex.advancedBy(-2) {
            if unicodeScalars[index].value == (unicodeScalars[index.successor()].value-1)
                && unicodeScalars[index].value == (unicodeScalars[index.successor().successor()].value-2) {
                    return true
            }
        }
        return false
    }
    
    func containsDoubleNonOverlappingTwoCharacters() -> Bool {
        var tuples = Set<String>()
        
        for index in startIndex...endIndex.advancedBy(-2) {
            let tuple = substringWithRange(Range<String.Index>(start: index, end: index.advancedBy(2)))
            if tuple.characters[tuple.startIndex]==tuple.characters[tuple.endIndex.predecessor()] {
                tuples.insert(tuple)
            }
        }
        
        return tuples.count > 1
    }
    
    func containsIllegalCharacters() -> Bool {
        for illegalCharacter in ["i", "o", "l"] {
            if containsString(illegalCharacter){
                return true
            }
        }
        return false
    }
    
    func isValid() -> Bool {
        return !containsIllegalCharacters()
            && containsStraight()
            && containsDoubleNonOverlappingTwoCharacters();
    }
}

input = input.next()
while (!input.isValid()) {
    input = input.next()
}
print(input)
