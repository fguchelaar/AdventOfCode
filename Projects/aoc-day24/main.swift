//
//  main.swift
//  aoc-day24
//
//  Created by Frank Guchelaar on 26/12/2016.
//  Copyright © 2016 Frank Guchelaar. All rights reserved.
//

import Foundation

var input = [
    1,
    2,
    3,
    5,
    7,
    13,
    17,
    19,
    23,
    29,
    31,
    37,
    41,
    43,
    53,
    59,
    61,
    67,
    71,
    73,
    79,
    83,
    89,
    97,
    101,
    103,
    107,
    109,
    113
]

// Part One
var targetWeight1 = input.reduce(0, +) / 3
print (targetWeight1)

/* No code needed, did it it by hand:
 
 1
 79
 103
 107
 109
 113
 
 */

// Part Two
var targetWeight2 = input.reduce(0, +) / 4
print (targetWeight2)

/* No code needed, did it it by hand:
 
 59
 103
 109
 113
 
 */
