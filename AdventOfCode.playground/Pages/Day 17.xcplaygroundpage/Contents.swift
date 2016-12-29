//: # Advent of Code - [Day 17](http://adventofcode.com/day/17)
import Foundation

var input = try String(contentsOf:#fileLiteral(resourceName: "input.txt"))
var containers  = input.components(separatedBy: .newlines).map { return Int($0)! }
print(containers)

func traverse(_ cups: Array<Int>, index : Int, usedCupIndexes : Array<Int>, target : Int) -> [[Int]] {
    var usedCupIndexes = usedCupIndexes
    var ret = [[Int]]()
    let sum = usedCupIndexes.reduce(0) { (s, index) -> Int in
        return s + cups[index]
    }
    
    if (sum >= target) {
        if sum==target {
            ret.append(usedCupIndexes)
        }
    }
    else {
        for i in index..<cups.count {
            
            if !usedCupIndexes.contains(i) {
                usedCupIndexes.append(i)
                ret += traverse(cups, index: i+1, usedCupIndexes: usedCupIndexes, target: target)
                usedCupIndexes.remove(at: usedCupIndexes.index(of: i)!)
            }
        }
    }
    return ret
}

let combos = traverse(containers, index: 0, usedCupIndexes: [Int](), target: 150)

//: Part One
print(combos.count)


//: Part Two
let minimumUsedCups = combos.reduce(Int.max) { (m, cups) -> Int in
    return min(m, cups.count)
}
let idealCups = combos.filter { (cups) -> Bool in
    return cups.count == minimumUsedCups
}
print(idealCups.count)
