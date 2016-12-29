//: # Advent of Code - [Day 3](http://adventofcode.com/day/3)
import Foundation

var input = try String(contentsOf:#fileLiteral(resourceName: "input.txt"))

//: Part one
print(DayThree(input: input).solveA())

//: Part two
print(DayThree(input: input).solveB())
