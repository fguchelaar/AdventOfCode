//: # Advent of Code - [Day 12](http://adventofcode.com/day/12)
import Foundation

var input = try String(contentsOfURL:[#FileReference(fileReferenceLiteral: "input.txt")#])

let regex = try NSRegularExpression(pattern: "(-?\\d+)", options: NSRegularExpressionOptions.CaseInsensitive)
var matches = regex.matchesInString(input, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, input.characters.count))

var numbers = [Int]()
for match in matches {
    numbers.append(Int(NSString(string: input).substringWithRange(match.range))!)
}

numbers.reduce(0, combine: +)


func convertStringToDictionary(text: String) -> [AnyObject]? {
    if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [AnyObject]
            return json
        } catch {
            print("Something went wrong")
        }
    }
    return nil
}

////: Part One
func solveA(tree : [AnyObject]) -> Int {
    
    var sum = 0
    for item in tree {
        switch item {
        case let i as Int:
            sum += i
        case let array as [AnyObject]:
            sum += solveA(array)
        case let dict as [String: AnyObject]:
            sum += solveA(Array(dict.values))
        default:
            break;
        }
    }
    
    return sum;
}

////: Part Two
func solveB(tree : [AnyObject]) -> Int {

    var sum = 0
    
    for item in tree {
        switch item {
        case let i as Int:
            sum += i
        case let array as [AnyObject]:
            sum += solveB(array)
        case let dict as [String: AnyObject]:
            if !(Array(dict.values) as NSArray).containsObject("red") {
                sum += solveB(Array(dict.values))
            }
        default: break
        }
    }
    
    return sum;
}

let tree = convertStringToDictionary(input)

print(solveA(tree!))
print(solveB(tree!))
