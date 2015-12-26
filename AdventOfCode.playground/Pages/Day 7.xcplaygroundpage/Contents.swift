//: # Advent of Code - [Day 7](http://adventofcode.com/day/7)
import Foundation

var input = try String(contentsOfURL:[#FileReference(fileReferenceLiteral: "input.txt")#])
var instructions = Set(input.componentsSeparatedByCharactersInSet(.newlineCharacterSet()))

var wires : Dictionary<String, Int16> = Dictionary<String,Int16>()

func valueForOperand(operand : String) -> Int16? {
    if let value = Int16(operand) {
        return value
    }
    else if let value = wires[operand] {
        return value
    }
    else {
        return nil
    }
}

while(!wires.contains { $0.0 == "a" }) {
    for instruction in instructions {
        
        let parts = instruction.componentsSeparatedByString(" -> ")
        let wire = parts[1]
        
        let circuit = parts[0].componentsSeparatedByString(" ")
        if circuit.count == 1 {
            if let value = valueForOperand(circuit[0]) {
                wires[wire] = value
                instructions.remove(instruction)
            }
        }
        else if circuit.count == 2 { // Always the NOT operator
            if let value = valueForOperand(circuit[1]) {
                wires[wire] = ~value
                instructions.remove(instruction)
            }
        }
        else if circuit.count == 3 {
            if let leftOperand = valueForOperand(circuit[0]) {
                if let rightOperand = valueForOperand(circuit[2]) {
                    switch (circuit[1]) {
                        case "AND":
                            wires[wire] = leftOperand & rightOperand
                        case "OR":
                            wires[wire] = leftOperand | rightOperand
                        case "RSHIFT":
                            wires[wire] = leftOperand >> rightOperand
                        case "LSHIFT":
                            wires[wire] = leftOperand << rightOperand
                        default:break
                    }
                    instructions.remove(instruction)
                }
            }
        }
    }
}
print(wires["a"])