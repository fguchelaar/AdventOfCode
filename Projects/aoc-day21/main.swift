//
//  main.swift
//  aoc-day21
//
//  Created by Frank Guchelaar on 25/12/2016.
//  Copyright © 2016 Frank Guchelaar. All rights reserved.
//

import Foundation

struct Player {
    let hitpoints: Int
    let damage: Int
    let armor: Int
}


let boss = Player(hitpoints: 100, damage: 8, armor: 2)

func willWin(player: Player, to boss: Player) -> Bool {
    let damageDealt = max(player.damage - boss.armor, 1)
    let damageReceived = max(boss.damage - player.armor, 1)
    
    return damageDealt >= damageReceived
}
func willLose(player: Player, to boss: Player) -> Bool {
    return !willWin(player: player, to: boss)
}

// Part One

// Simply deduced it by looking at the items in the store
// Longsword(40) + Chainmail(31) + Def+1(20)
let player1 = Player(hitpoints: 100, damage: 7, armor: 3)

print (willWin(player: player1, to: boss))

// Part Two

struct Item : CustomStringConvertible {
    let cost: Int
    let damage: Int
    let armor: Int
    
    var description: String {
        return "$\(cost) - \(damage)/\(armor)"
    }
}

let weapons = [
    Item(cost: 8, damage: 4, armor: 0),
    Item(cost: 10, damage: 5, armor: 0),
    Item(cost: 25, damage: 6, armor: 0),
    Item(cost: 40, damage: 7, armor: 0),
    Item(cost: 74, damage: 8, armor: 0)
]

let armors = [
    Item(cost: 0, damage: 0, armor: 0),
    Item(cost: 13, damage: 0, armor: 1),
    Item(cost: 31, damage: 0, armor: 2),
    Item(cost: 53, damage: 0, armor: 3),
    Item(cost: 75, damage: 0, armor: 4),
    Item(cost: 102, damage: 0, armor: 5)
]

let rings = [
    Item(cost: 0, damage: 0, armor: 0),
    Item(cost: 0, damage: 0, armor: 0),
    Item(cost: 25, damage: 1, armor: 0),
    Item(cost: 50, damage: 2, armor: 0),
    Item(cost: 100, damage: 3, armor: 0),
    Item(cost: 20, damage: 0, armor: 1),
    Item(cost: 40, damage: 0, armor: 2),
    Item(cost: 80, damage: 0, armor: 3)
]

var loosingEquipments = [[Item]]()

for weapon in weapons {
    
    for armor in armors {
        
        for (i1, ring1) in rings.enumerated() {
            
            for (i2, ring2) in rings.enumerated() {

                if i2 == i1 { // Can't buy the same ring twice
                    continue
                }
                
                let equipment = [
                    weapon,
                    armor,
                    ring1,
                    ring2
                ]
                
                let damage = equipment.reduce(0) { $0 + $1.damage }
                let armor = equipment.reduce(0) { $0 + $1.armor }
                if willLose(player: Player(hitpoints: 100, damage: damage, armor: armor), to: boss) {
                    loosingEquipments.append(equipment)
                }
            }
        }
    }
}

let maxCost = loosingEquipments
    .map { String.init(format: "%03d - %@", $0.reduce(0) { $0 + $1.cost }, $0) }
    .sorted(by: >)

print (maxCost.joined(separator: "\n"))
