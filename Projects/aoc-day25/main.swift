//
//  main.swift
//  aoc-day25
//
//  Created by Frank Guchelaar on 28/12/2016.
//  Copyright © 2016 Frank Guchelaar. All rights reserved.
//

import Foundation

func indexFor(row: Int, column: Int) -> Int {
    let base = Array(1...column).reduce(0, +)
    let add = Array(0..<row-1).reduce(0) { $0 + (column + $1) }
    return base + add
}

func codeFor(index: Int) -> Int {
    var code = 20151125
    for _ in 1..<index {
        code = (code * 252533) % 33554393
    }
    return code
}

let target = (row: 2978, column: 3083)
print ("1) \(codeFor(index: indexFor(row: target.row, column: target.column)))")
