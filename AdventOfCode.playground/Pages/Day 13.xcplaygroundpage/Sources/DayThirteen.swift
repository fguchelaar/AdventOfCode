import Foundation

open class MyArray<Element> {
    
    var array : Array<Element>
   
    public init(array: Array<Element>) {
        self.array = array
    }
    
    open func permutations() -> [[Element]] {
        return permutations(0)
    }

    open func permutations(_ start: Int) -> [[Element]] {
        var permutations = [[Element]]()
        permute(start, end: array.count-1, permutations: &permutations, depth: 0)
        return permutations
    }
    
    func permute(_ start : Int, end : Int, permutations : inout [[Element]], depth: Int) {
        if start >= end {
            permutations.append(array)
        }
        else {
            for pos in start...end {
                swap(start, pos)
                permute(start+1, end: end, permutations: &permutations, depth: depth+1)
                swap(start, pos) // Backtrack
            }
        }
    }
    
    func swap(_ x: Int, _ y : Int) {
        let temp = array[x]
        array[x] = array[y]
        array[y] = temp
    }
}
