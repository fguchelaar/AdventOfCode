//: # Advent of Code - [Day 12](http://adventofcode.com/day/12)
import Foundation

var input = try String(contentsOf:#fileLiteral(resourceName: "input.txt"))

let regex = try NSRegularExpression(pattern: "(-?\\d+)", options: NSRegularExpression.Options.caseInsensitive)
var matches = regex.matches(in: input, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, input.characters.count))

var numbers = [Int]()
for match in matches {
    numbers.append(Int(NSString(string: input).substring(with: match.range))!)
}

numbers.reduce(0, +)


func convertStringToDictionary(_ text: String) -> [AnyObject]? {
    if let data = text.data(using: String.Encoding.utf8) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [AnyObject]
            return json
        } catch {
            print("Something went wrong")
        }
    }
    return nil
}

////: Part One
func solveA(_ tree : [AnyObject]) -> Int {
    
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
func solveB(_ tree : [AnyObject]) -> Int {

    var sum = 0
    
    for item in tree {
        switch item {
        case let i as Int:
            sum += i
        case let array as [AnyObject]:
            sum += solveB(array)
        case let dict as [String: AnyObject]:
            if !(Array(dict.values) as NSArray).contains("red") {
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
