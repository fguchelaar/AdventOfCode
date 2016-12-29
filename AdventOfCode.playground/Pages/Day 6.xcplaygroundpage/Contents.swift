//: # Advent of Code - [Day 6](http://adventofcode.com/day/6)
import Foundation

var input = try String(contentsOf:#fileLiteral(resourceName: "input.txt"))

//: Part one
print(DaySix(input: input).solveA())

//: Part two
print(DaySix(input: input).solveB())
