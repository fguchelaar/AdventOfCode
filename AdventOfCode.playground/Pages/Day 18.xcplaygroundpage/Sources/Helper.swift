import Foundation

public class Helper {
    
    var rows = 100
    var cols = 100

    var grid : Array<Array<String>>

    public init(input : String) {
        grid = Helper.inputToGrid(input)
        cols = grid.count
        rows = grid[0].count
    }
    
    public static func inputToGrid(input : String) -> Array<Array<String>> {
        var grid = Array<Array<String>>()
        for inputRow in input.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) {
            grid.append(inputRow.characters.map { String($0) })
            
        }
        return grid
    }
    
    func numberOfNeighboursOn(x : Int, _ y : Int) -> Int {
        var sum = 0
        for c in x-1...x+1 {
            if c >= 0 && c<cols { // check for bounds
                for r in y-1...y+1 {
                    if r >= 0 && r<rows { // check for bounds
                        // skip ourself
                        if c == x && r == y {
                            continue
                        }
                        if grid[c][r] == "#" {
                            sum++
                        }
                    }
                }
            }
        }
        return sum
    }
    
    func sumOfOn() -> Int {
        return grid.reduce(0, combine: { (s, gridRows) -> Int in
            return s + gridRows.reduce(0, combine: { (s2, light) -> Int in
                return s2 + (light=="#" ? 1 : 0)
            })
        })
    }
    
    public func solveA(runs : Int) -> Int {
        print("0: \(sumOfOn()) lights on")
        
        for run in 0..<runs {
        
            var newGrid = Array<Array<String>>(count: cols, repeatedValue: Array<String>(count:rows, repeatedValue: "."))
            
            for col in 0..<grid.count {
                for row in 0..<grid[col].count {
                
                    let neighboursOn = numberOfNeighboursOn(col, row)
                    if grid[col][row] == "#" {
                        if neighboursOn == 2 || neighboursOn == 3 {
                            newGrid[col][row] = "#"
                        }
                    }
                    else {
                        if neighboursOn == 3 {
                            newGrid[col][row] = "#"
                        }
                    }
                }
            }
            grid = newGrid
            
            print("\(run+1): \(sumOfOn()) lights on")
        }
        return sumOfOn()
    }

    public func solveB(runs : Int) -> Int {
        grid[0][0] = "#"
        grid[grid.count-1][0] = "#"
        grid[0][grid[0].count-1] = "#"
        grid[grid.count-1][grid[0].count-1] = "#"

        print("0: \(sumOfOn()) lights on")

        for run in 0..<runs {
            
            var newGrid = Array<Array<String>>(count: cols, repeatedValue: Array<String>(count:rows, repeatedValue: "."))
            
            for col in 0..<grid.count {
                for row in 0..<grid[col].count {
                    
                    let neighboursOn = numberOfNeighboursOn(col, row)
                    if grid[col][row] == "#" {
                        if neighboursOn == 2 || neighboursOn == 3 {
                            newGrid[col][row] = "#"
                        }
                    }
                    else {
                        if neighboursOn == 3 {
                            newGrid[col][row] = "#"
                        }
                    }
                }
            }
            
            newGrid[0][0] = "#"
            newGrid[newGrid.count-1][0] = "#"
            newGrid[0][newGrid[0].count-1] = "#"
            newGrid[newGrid.count-1][newGrid[0].count-1] = "#"
            
            grid = newGrid
            
            print("\(run+1): \(sumOfOn()) lights on")
        }
        return sumOfOn()
    }
}