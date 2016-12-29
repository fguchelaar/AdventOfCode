//: # Advent of Code - [Day 17](http://adventofcode.com/day/17)
import Foundation

var input = try String(contentsOf:#fileLiteral(resourceName: "input.txt"))
//var input = try String(contentsOfURL:[#FileReference(fileReferenceLiteral: "example.txt")#])

//let a = Helper(input: input).solveA(100)
let b = Helper(input: input).solveB(100)
