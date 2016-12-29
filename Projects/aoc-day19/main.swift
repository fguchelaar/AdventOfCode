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
func singlePassMutations(molecule: String, replacements: [(a: String, b: String)]) -> [String] {
    
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

let unique = Set(singlePassMutations(molecule: medicine, replacements: replacements))
print ("1) \(unique.count)")

// Part Two

func demutate(molecule: String, replacements: [(a: String, b: String)]) -> String {
    
    // Strategy: always try to do the largest one first
//    let sorted = repl
}
