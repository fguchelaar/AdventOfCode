//
//  main.swift
//  aoc-day23
//
//  Created by Frank Guchelaar on 26/12/2016.
//  Copyright © 2016 Frank Guchelaar. All rights reserved.
//

import Foundation

var input = try String(contentsOfFile: "day23/input.txt")
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .components(separatedBy: .newlines)

class Computer {
    
    var registers : [String : Int]
    
    init (a: Int, b: Int) {
        registers = [
            "a": a,
            "b": b
        ]
    }
    
    //    func copy(value: Int, in register: String) {
    //        registers[register] = value
    //    }
    //
    //    func copy(from: String, to: String) {
    //        registers[to]=registers[from]
    //    }
    
    func halve(register: String) {
        registers[register] = registers[register]! / 2
    }
    
    func triple(register: String) {
        registers[register] = registers[register]! * 3
    }
    
    //    func decrement(register: String) {
    //        registers[register] = (registers[register] ?? 0) - 1
    //    }
    //
    func increment(register: String) {
        registers[register] = (registers[register] ?? 0) + 1
    }
}

class Solver {
    var computer: Computer
    var instructions: [String]
    
    init(computer: Computer, instructions: [String]) {
        self.computer = computer
        self.instructions = instructions
    }
    
    var output = [Int]()
    
    func solve() {
        
        var i = 0
        while i < instructions.count {
            autoreleasepool {
                
                let components = instructions[i].components(separatedBy: " ")
                
                switch components[0] {
                case "jmp":
                    let value = Int(components[1])!
                    i += value - 1 // -1 to account for the +1 later on. I'd rather `continue`, but since we're in a `autorelease` block, that's not possible
                case "jio":
                    let value = computer.registers[String(components[1].characters.first!)]!
                    if (value ==  1) {
                        let jump = (Int(components[2]) ?? computer.registers[components[2]])!
                        i += jump - 1 // -1 to account for the +1 later on. I'd rather `continue`, but since we're in a `autorelease` block, that's not possible
                    }
                case "jie":
                    let value = computer.registers[String(components[1].characters.first!)]!
                    if (value % 2 ==  0) {
                        let jump = (Int(components[2]) ?? computer.registers[components[2]])!
                        i += jump - 1 // -1 to account for the +1 later on. I'd rather `continue`, but since we're in a `autorelease` block, that's not possible
                    }
                case "hlf":
                    computer.halve(register: components[1])
                case "tpl":
                    computer.triple(register: components[1])
                case "inc":
                    computer.increment(register: components[1])
                    //                case "dec":
                //                    computer.decrement(register: components[1])
                default:
                    print ("skipping illegal instruction: \(instructions[i])")
                }
                
                i += 1
            }
        }
    }
}

// Part One

let computer1 = Computer(a: 0, b: 0)
Solver(computer: computer1, instructions: input).solve()
print ("1) \(computer1.registers)")

// Part Two

let computer2 = Computer(a: 1, b: 0)
Solver(computer: computer2, instructions: input).solve()
print ("2) \(computer2.registers)")

