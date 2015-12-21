//: # Advent of Code - [Day 6](http://adventofcode.com/day/6)
import Foundation

let rows = 4
let columns = 4

var lights = [[Bool]](count: rows, repeatedValue: [Bool](count: columns, repeatedValue: false))

func setVal(x1 : Int, _ y1 : Int, _ x2: Int, _ y2 : Int, val: (Bool) -> (Bool)) {
    for col in x1...x2 {
        for row in y1...y2 {
            lights[col][row] = val(lights[col][row])
        }
    }
}

func toggle(x1 : Int, _ y1 : Int, _ x2: Int, _ y2 : Int) {
    setVal(x1, y1, x2, y2) { (current) -> (Bool) in
        return !current;
    }
}

func turnOn(x1 : Int, _ y1 : Int, _ x2: Int, _ y2 : Int) {
    setVal(x1, y1, x2, y2) { _ -> (Bool) in
        return true;
    }
}

func turnOff(x1 : Int, _ y1 : Int, _ x2: Int, _ y2 : Int) {
    setVal(x1, y1, x2, y2) { _ -> (Bool) in
        return false;
    }
}

toggle(1,1,3,2)
turnOn(0,0,0,1)

let numberOfLightsOn = lights.reduce(0) { (sumOfRows, rows) -> Int in
    return sumOfRows + rows.reduce(0, combine: { (sumOfColumns, isOn) -> Int in
        return sumOfColumns + (isOn ? 1 : 0)
    })
}