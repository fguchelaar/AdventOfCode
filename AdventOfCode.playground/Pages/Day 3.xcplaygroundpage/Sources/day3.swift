import Foundation

open class DayThree {
    var input : String

    public init(input: String) {
        self.input = input
    }
    
    func visitedHouses(_ commands: [Character]) -> Set<String> {
        var visits = Array<String>()
        var location : (Int, Int) = (0,0)
        visits.append("\(location.0).\(location.1)")
        for char in commands {
            switch char {
            case "^":
                location.0 += 1
            case "v":
                location.0 -= 1
            case ">":
                location.1 += 1
            case "<":
                location.1 -= 1
            default:
                break
            }
            visits.append("\(location.0).\(location.1)")
        }
        return Set(visits)
    }
    
    open func solveA() -> Int {
        return visitedHouses(input.characters.map {$0} ).count
    }
    
    open func solveB() -> Int {
        let santa = input.characters.enumerated().filter { $0.offset % 2 == 0 }.map { $0.element }
        let roboSanta = input.characters.enumerated().filter { $0.offset % 2 == 1 }.map { $0.element }
        return visitedHouses(santa).union(visitedHouses(roboSanta)).count
    }
}
