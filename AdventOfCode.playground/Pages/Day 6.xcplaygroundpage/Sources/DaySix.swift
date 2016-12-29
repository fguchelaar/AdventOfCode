import Foundation

struct Light {
    var state : Bool = false
    var brightness : Int = 0
    
    mutating func toggle() {
        state = !state
        brightness += 2
    }
    
    mutating func turnOn() {
        state = true
        brightness += 1
    }

    mutating func turnOff() {
        state = false
        brightness = max(0, brightness-1)
    }
}

open class DaySix {

    var commands : [String]
    let rows = 1000
    let columns = 1000

    var lights : [[Light]]
    
    public init(input: String) {
        commands = input.components(separatedBy: .newlines)
        lights = [[Light]](repeating: [Light](repeating: Light(), count: columns), count: rows)
        for command in commands {
            performCommand(command)
        }
    }
    

    func toggle(_ x1 : Int, _ y1 : Int, _ x2: Int, _ y2 : Int) {
        for col in x1...x2 {
            for row in y1...y2 {
                lights[col][row].toggle()
            }
        }
    }
    
    func turnOn(_ x1 : Int, _ y1 : Int, _ x2: Int, _ y2 : Int) {
        for col in x1...x2 {
            for row in y1...y2 {
                lights[col][row].turnOn()
            }
        }
    }
    
    func turnOff(_ x1 : Int, _ y1 : Int, _ x2: Int, _ y2 : Int) {
        for col in x1...x2 {
            for row in y1...y2 {
                lights[col][row].turnOff()
            }
        }
    }
    
    func rangeFromCommand(_ command : String) -> (x1:Int, y1:Int, x2:Int,y2:Int) {
        let index = command.rangeOfCharacter(from: CharacterSet(charactersIn: "123456789"))
        
        let parts = command.substring(from: index!.lowerBound).components(separatedBy: CharacterSet(charactersIn: " ,"))
        
        return (Int(parts[0])!, Int(parts[1])!,Int(parts[3])!, Int(parts[4])!)
    }
    
    func performCommand(_ command : String) {

        let range = rangeFromCommand(command)

        if command.hasPrefix("turn on") {
            turnOn(range.x1, range.y1, range.x2, range.y2)
        }
        else if command.hasPrefix("turn off") {
            turnOff(range.x1, range.y1, range.x2, range.y2)
        }
        if command.hasPrefix("toggle") {
            toggle(range.x1, range.y1, range.x2, range.y2)
        }
    }
        

    open func solveA() -> Int {
        
        let numberOfLightsOn = lights.reduce(0) { (sumOfRows, rows) -> Int in
            return sumOfRows + rows.reduce(0, { (sumOfColumns, light) -> Int in
                return sumOfColumns + (light.state ? 1 : 0)
            })
        }
        return numberOfLightsOn
    }
    
    open func solveB() -> Int {
        let totalBrightness = lights.reduce(0) { (sumOfRows, rows) -> Int in
            return sumOfRows + rows.reduce(0, { (sumOfColumns, light) -> Int in
                return sumOfColumns + light.brightness
            })
        }
        return totalBrightness
    }
}
