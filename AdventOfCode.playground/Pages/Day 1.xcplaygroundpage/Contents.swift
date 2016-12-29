//: # Advent of Code - [Day 1](http://adventofcode.com/day/1)
import Foundation

var input = try String(contentsOf:#fileLiteral(resourceName: "input.txt"))

//: Part one
var f = input.characters.reduce(0) { (floor, char) -> Int in
    return floor + (char == "(" ? 1 : -1)
}

//: Part two
var floor = 0
var index = 0
let searchForFloor = -1

for char in input.characters {
    index += 1
    floor += (char == "(" ? 1 : -1)
    if(floor == searchForFloor) {
        break
    }
}

print("Entered \(floor) on \(index)")
