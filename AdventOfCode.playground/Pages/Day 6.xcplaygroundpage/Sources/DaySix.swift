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

public class DaySix {

    var commands : [String]
    let rows = 1000
    let columns = 1000

    var lights : [[Light]]
    
    public init(input: String) {
        commands = input.componentsSeparatedByCharactersInSet(.newlineCharacterSet())
        lights = [[Light]](count: rows, repeatedValue: [Light](count: columns, repeatedValue: Light()))
        for command in commands {
            performCommand(command)
        }
    }
    

    func toggle(x1 : Int, _ y1 : Int, _ x2: Int, _ y2 : Int) {
        for col in x1...x2 {
            for row in y1...y2 {
                lights[col][row].toggle()
            }
        }
    }
    
    func turnOn(x1 : Int, _ y1 : Int, _ x2: Int, _ y2 : Int) {
        for col in x1...x2 {
            for row in y1...y2 {
                lights[col][row].turnOn()
            }
        }
    }
    
    func turnOff(x1 : Int, _ y1 : Int, _ x2: Int, _ y2 : Int) {
        for col in x1...x2 {
            for row in y1...y2 {
                lights[col][row].turnOff()
            }
        }
    }
    
    func rangeFromCommand(command : String) -> (x1:Int, y1:Int, x2:Int,y2:Int) {
        let index = command.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "123456789"))
        
        let parts = command.substringFromIndex(index!.startIndex).componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: " ,"))
        
        return (Int(parts[0])!, Int(parts[1])!,Int(parts[3])!, Int(parts[4])!)
    }
    
    func performCommand(command : String) {

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
        

    public func solveA() -> Int {
        
        let numberOfLightsOn = lights.reduce(0) { (sumOfRows, rows) -> Int in
            return sumOfRows + rows.reduce(0, combine: { (sumOfColumns, light) -> Int in
                return sumOfColumns + (light.state ? 1 : 0)
            })
        }
        return numberOfLightsOn
    }
    
    public func solveB() -> Int {
        let totalBrightness = lights.reduce(0) { (sumOfRows, rows) -> Int in
            return sumOfRows + rows.reduce(0, combine: { (sumOfColumns, light) -> Int in
                return sumOfColumns + light.brightness
            })
        }
        return totalBrightness
    }
}