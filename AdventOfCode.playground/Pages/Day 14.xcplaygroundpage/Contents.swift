//: # Advent of Code - [Day 14(http://adventofcode.com/day/14)
import Foundation

var input = try String(contentsOf:#fileLiteral(resourceName: "input.txt"))
var specs = input.components(separatedBy: .newlines)

struct Reindeer : Hashable, Equatable {
    var name : String
    var speed : Int
    var active : Int
    var rest : Int
    
    var totalTime : Int {
        return active + rest
    }
    
    func distanceAfter(_ seconds: Int) -> Int {
        let totalStints = seconds / totalTime
        let extraSeconds = min(active, seconds % totalTime)
        
        return (totalStints * active * speed) + (extraSeconds * speed)
    }
    
    var hashValue : Int {
        return (name).hashValue
    }
}

func ==(lhs: Reindeer, rhs: Reindeer) -> Bool {
    return lhs.name == rhs.name
}

//: Part One
for spec in specs {
    var parts = spec.components(separatedBy: " ")
    let reindeer = Reindeer(name: parts[0], speed: Int(parts[3])!, active: Int(parts[6])!, rest: Int(parts[13])!)
    print("\(reindeer.name)\t\(reindeer.distanceAfter(2503))")
}

//: Part Two
var reindeers = [Reindeer : Int]()

for spec in specs {
    var parts = spec.components(separatedBy: " ")
    let reindeer = Reindeer(name: parts[0], speed: Int(parts[3])!, active: Int(parts[6])!, rest: Int(parts[13])!)
    reindeers[reindeer] = 0
}

for second in 1...2503 {

    let furthestDistance = reindeers.reduce(0, { (currentMax, reindeer: (Reindeer, Int)) -> Int in
        return max(currentMax, reindeer.0.distanceAfter(second))
    })
    
    for reindeer in reindeers {
        let distance = reindeer.0.distanceAfter(second)
        reindeers[reindeer.0] = distance == furthestDistance ? reindeer.1 + 1 : reindeer.1
    }
}

for reindeer in reindeers {
    print (reindeer)
}
