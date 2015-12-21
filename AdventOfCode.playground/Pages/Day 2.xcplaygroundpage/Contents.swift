//: # Advent of Code - [Day 2](http://adventofcode.com/day/2)
import Foundation

var input = try String(contentsOfURL:[#FileReference(fileReferenceLiteral: "input.txt")#])

//: Part one
struct Present {
    var l : Int
    var w : Int
    var h : Int
    
    init(dimensions : String) {
        let dim = dimensions.componentsSeparatedByString("x").map { return Int($0)! }
        l = dim[0]
        w = dim[1]
        h = dim[2]
    }
    
    var paperNeeded : Int {
        
        let lw = l*w
        let wh = w*h
        let hl = h*l
        let slack = min(min(lw, wh), hl)
        
        return (2*lw) + (2*wh) + (2*hl) + slack
    }
}

var presents = input.componentsSeparatedByCharactersInSet(.newlineCharacterSet()).map { Present(dimensions: $0) }

var totalPaperNeeded = presents.reduce(0) { (cumulative, present) -> Int in
    return cumulative + present.paperNeeded
}

//: Part two
extension Present {
    var ribbonLength : Int {
        let lw = l+l+w+w
        let wh = w+w+h+h
        let hl = h+h+l+l
        let wrap = min(min(lw, wh), hl)
        let bow = l*w*h
        
        return wrap + bow
    }
}

var totalRibbonLenghtNeeded = presents.reduce(0) { (cumulative, present) -> Int in
    return cumulative + present.ribbonLength
}