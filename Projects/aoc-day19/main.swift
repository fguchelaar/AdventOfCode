//
//  main.swift
//  aoc-day19
//
//  Created by Frank Guchelaar on 29/12/2016.
//  Copyright © 2016 Frank Guchelaar. All rights reserved.
//

import Foundation

let lines = try String(contentsOfFile: "day19/input.txt")
    .components(separatedBy: .newlines)

let replacements : [(a: String, b: String)] = lines
    .map { $0.components(separatedBy: " => ") }
    .filter { $0.count == 2 }
    .map { (a: $0[0], b: $0[1]) }

let medicine = lines.last!

// Part One
func singlePassMutations(_ molecule: String, replacements: [(a: String, b: String)]) -> [String] {
    
    var mutations = [String]()
    
    for replacement in replacements {
        var r = Range<String.Index>(uncheckedBounds: (lower: molecule.startIndex, upper: molecule.endIndex))
        while let range = molecule.range(of: replacement.a, options: String.CompareOptions.init(rawValue: 0), range: r, locale: nil) {
            mutations.append(molecule.replacingCharacters(in: range, with: replacement.b))
            r = Range<String.Index>(uncheckedBounds: (lower: range.upperBound, upper: molecule.endIndex))
        }
    }
    return mutations
}

let unique = Set(singlePassMutations(medicine, replacements: replacements))
print ("1) \(unique.count)")

// Part Two

func demutate(_ molecule: String, replacements: [(a: String, b: String)]) -> (molecule: String, steps: Int) {
    
    var str = molecule
    
    let sorted = replacements.sorted { $0.b > $1.b }
    
    var index = 0
    
    var steps = 0
    
    while index < sorted.count {
        
        let replacement = sorted[index]
        var newStr = str

        var r = Range<String.Index>(uncheckedBounds: (lower: newStr.startIndex, upper: newStr.endIndex))

        while let range = newStr.range(of: replacement.b, options: String.CompareOptions.init(rawValue: 0), range: r, locale: nil) {
            let newNewStr = newStr.replacingCharacters(in: range, with: replacement.a)
            if newNewStr != newStr {
                steps += 1
                //print ("After \(replacement.b) => \(replacement.a):\t\(newStr)")
                newStr = newNewStr
            }
            r = Range<String.Index>(uncheckedBounds: (lower: min(range.upperBound, newStr.endIndex), upper: newStr.endIndex))
        }
        
        if newStr != str {
            index = 0
            str = newStr
        }
        else {
            index += 1
        }
    }
    return (str, steps)
}


print ("2) \(demutate(medicine, replacements: replacements))")
