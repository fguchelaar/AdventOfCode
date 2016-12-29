//
//  main.swift
//  aoc-day20
//
//  Created by Frank Guchelaar on 25/12/2016.
//  Copyright © 2016 Frank Guchelaar. All rights reserved.
//

import Foundation

let target = 33100000

// Part One

for house in 1...Int.max {
    
    let sq = Int(sqrt(Double(house)))
    
    var visits = [Int]()
    for i in 1...sq {
        if house % i == 0 {
            visits.append(i)
            if i * i != house {
                visits.append(house / i)
            }
        }
    }
    let vval = visits.reduce(0) { $0 + $1 } * 10
    
    if vval >= target {
        let vstr = visits
            .sorted(by: <)
            .map { String($0) }
            .joined(separator: ",")
        
        print ("\(house): [\(vval)] \(vstr)")
        break
    }
}

// Part two

for house in 1...Int.max {
    
    let sq = Int(sqrt(Double(house)))
    
    var visits = [Int]()
    for i in 1...sq {
        if house % i == 0 {
            visits.append(i)
            if i * i != house {
                visits.append(house / i)
            }
        }
    }
    
    let actualVisits = visits
        .filter { $0 > house / 50 }
        .sorted(by: <)
    
    let vval = actualVisits.reduce(0) { $0 + $1 } * 11
    
    if vval >= target {
        let vstr = actualVisits
            .map { String($0) }
            .joined(separator: ",")
        
        print ("\(house): [\(vval)] \(vstr)")
        break
    }
}
