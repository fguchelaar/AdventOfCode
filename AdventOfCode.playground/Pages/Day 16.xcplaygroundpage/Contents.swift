//: # Advent of Code - [Day 16](http://adventofcode.com/day/16)
import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


var input = try String(contentsOf:#fileLiteral(resourceName: "input.txt"))
input = input.replacingOccurrences(of: ":", with: "")
input = input.replacingOccurrences(of: ",", with: "")

struct Aunt {
    var name : String
    var properties = [String : Int]()
    
    init(name: String) {
        self.name = name
    }
}

var aunts = [Aunt]()

for var line in input.components(separatedBy: .newlines) {
    
    let parts = line.components(separatedBy: " ")

    var aunt = Aunt(name: parts[1])
    for var index = 2; index < parts.count; index=index+2 {
        aunt.properties[parts[index]] = Int(parts[index+1])
    }
    aunts.append(aunt)
}

let tickerTape : [String : Int] = [
    "children": 3,
    "cats": 7,
    "samoyeds": 2,
    "pomeranians": 3,
    "akitas": 0,
    "vizslas": 0,
    "goldfish": 5,
    "trees": 3,
    "cars": 2,
    "perfumes": 1
]

var maxPoints = -1

print("Part One:")

for aunt in aunts {
    let points = aunt.properties.reduce(0, { (p, property) -> Int in
        
        if tickerTape[property.0] == property.1 {
            return p+1
        }
        else {
            return p
        }
    })
    if points > maxPoints {
        maxPoints = points
        print("\(points):\t\(aunt)")
    }
}

maxPoints = -1

print("Part Two:")
for aunt in aunts {
    let points = aunt.properties.reduce(0, { (p, property) -> Int in

        if (property.0 == "cats" || property.0 == "trees") {
            if tickerTape[property.0] < property.1 {
                return p+1
            }
            return p
        }
        else if (property.0 == "pomeranians" || property.0 == "goldfish") {
            if tickerTape[property.0] > property.1 {
                return p+1
            }
            return p
        }
        else if tickerTape[property.0] == property.1 {
            return p+1
        }
        else {
            return p
        }
    })
    if points >= maxPoints {
        maxPoints = points
        print("\(points):\t\(aunt)")
    }
}
