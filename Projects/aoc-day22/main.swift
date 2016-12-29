//
//  main.swift
//  aoc-day22
//
//  Created by Frank Guchelaar on 27/12/2016.
//  Copyright © 2016 Frank Guchelaar. All rights reserved.
//

import Foundation

func printState(wizard: Wizard, boss: Boss) {
//    print("=> [w] \(wizard.hitPoints)hp -- [b] \(boss.hitPoints)hp")
}

class Boss {
    var hitPoints: Int
    var damage: Int
    
    init(hitPoints: Int, damage: Int) {
        self.hitPoints = hitPoints
        self.damage = damage
    }
    
    func attack(wizard: Wizard) {
//        print ("[b] Attack")
        wizard.takeDamage(damage: damage)
        printState(wizard: wizard, boss: self)
    }
}

class Wizard {
    var hitPoints: Int
    var mana: Int
    var armor: Int = 0
    
    let spellbook : [Spell]
    
    var activeSpells = [Spell: Int]()
    
    init(hitPoints: Int, mana: Int, spellbook: [Spell]) {
        self.hitPoints = hitPoints
        self.mana = mana
        self.spellbook = spellbook
    }
    
    func selectRandomSpell() -> Spell? {
        let affordable = self.spellbook.filter { $0.manaCosts <= mana }
        if affordable.count == 0 {
            return nil
        }
        let idx = arc4random_uniform(UInt32(affordable.count))
        return affordable[Int(idx)].copy(with: nil) as? Spell
    }
    func cast(spell: Spell, at boss: Boss) {
//        print("[w] Casting '\(spell.title)'")
        mana -= spell.manaCosts
        spell.execute(wizard: self, boss: boss)
        printState(wizard: self, boss: boss)
    }
    
    func takeDamage(damage: Int) {
        hitPoints -= max(damage - armor ,1)
    }
}

class Spell  : Hashable, Equatable, NSCopying {
    var title: String = ""
    var manaCosts: Int
    var damage: Int = 0
    var heal: Int = 0
    
    init(title: String, mp: Int) {
        self.title = title
        manaCosts = mp
    }
    
    convenience init(title: String, mp: Int, damage: Int) {
        self.init(title: title, mp: mp)
        self.damage = damage
    }
    
    convenience init(title: String, mp: Int, damage: Int, heal: Int) {
        self.init(title: title, mp: mp, damage: damage)
        self.heal = heal
    }
    
    func execute(wizard: Wizard, boss: Boss) {
        wizard.hitPoints += heal
        boss.hitPoints -= damage
    }
    
    public static func ==(lhs: Spell, rhs: Spell) -> Bool {
        return lhs.title == rhs.title
    }
    
    var hashValue: Int {
        return title.hashValue
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Spell(title: title, mp: manaCosts, damage: damage, heal: heal)
        return copy
    }
}

class Effect : Spell {
    var ttl: Int = 0
    var recharge: Int = 0
    
    convenience init(title: String, mp: Int, damage: Int, heal: Int, recharge: Int, ttl: Int) {
        self.init(title: title, mp: mp, damage: damage, heal: heal)
        self.ttl = ttl
        self.recharge = recharge
    }
    var activate : ((Wizard, Boss) -> Void)?
    var deactivate : ((Wizard, Boss) -> Void)?
    
    override func execute(wizard: Wizard, boss: Boss) {
        super.execute(wizard: wizard, boss: boss)
        wizard.mana += recharge
    }
    
    override func copy(with zone: NSZone?) -> Any {
        let copy = Effect(title: title, mp: manaCosts, damage: damage, heal: heal, recharge: recharge, ttl: ttl)
        copy.activate = self.activate
        copy.deactivate = self.deactivate
        return copy
    }
}

class Game {
    var effects = [Effect]()
    var wizard: Wizard
    var boss: Boss
    
    init(wizard: Wizard, boss: Boss) {
        self.wizard = wizard
        self.boss = boss
    }
    
    func applyEffects() {
        if effects.count > 0 {
//            print ("Applying effects...")
        }
        for effect in effects {
//            print("[e] Casting '\(effect.title)' ttl=\(effect.ttl)")
            effect.execute(wizard: wizard, boss: boss)
            effect.ttl -= 1
            if effect.ttl == 0 {
                if let d = effect.deactivate {
//                    print ("Deactivate '\(effect.title)'")
                    d(wizard,boss)
                }
            }
        }
        effects = effects.filter { $0.ttl > 0 }
    }
    
    func playRandomGame() -> (won: Bool, spells: [Spell]) {
        
        var castedSpells = [Spell]()
        
        while true {
            
            // (un)comment for part two
            wizard.hitPoints -= 1
            if wizard.hitPoints <= 0 {
                break;
            }

            applyEffects()
            if boss.hitPoints <= 0  {
                break
            }
            
            var spell : Spell?
            repeat {
                spell = wizard.selectRandomSpell()
            } while spell is Effect && effects.contains(spell as! Effect)

            if spell == nil { // not enough mana
                wizard.hitPoints = 0
                break
            }
            
            castedSpells.append(spell!)
            
//            print ("Selected spell '\(spell!.title)'")
            if let effect = spell as? Effect {
                effects.append(effect)
                wizard.mana -= effect.manaCosts
                if let a = effect.activate {
//                    print ("Activate '\(effect.title)'")
                    a(wizard, boss)
                }
            }
            else {
                wizard.cast(spell: spell!, at: boss)
            }
            
            if boss.hitPoints <= 0  {
                break
            }
            
            applyEffects()
            
            if boss.hitPoints <= 0  {
                break
            }
            
            boss.attack(wizard: wizard)
            
            if wizard.hitPoints <= 0 {
                break;
            }
        }
//        print("== Aftermath:\tWizard:\t\(wizard.hitPoints)hp \tBoss:\t\(boss.hitPoints)hp")
        return (boss.hitPoints <= 0, castedSpells)
    }
}

// Spells
let magicMissile = Spell(title: "Magic Missile", mp: 53, damage: 4)
let drain = Spell(title: "Drain", mp: 73, damage: 2, heal: 2)
let shield = Effect(title: "Shield", mp: 113, damage: 0, heal: 0, recharge: 0, ttl: 6)
shield.activate = {(wizard, boss) -> Void in
    wizard.armor += 7
}
shield.deactivate = {(wizard, boss) -> Void in
    wizard.armor -= 7
}
let poison = Effect(title: "Poison", mp: 173, damage: 3, heal: 0, recharge: 0, ttl: 6)
let recharge = Effect(title: "Recharge", mp: 229, damage: 0, heal: 0, recharge: 101, ttl: 5)

let allSpells = [
    magicMissile,
    drain,
    shield,
    poison,
    recharge
]

var results = [[Spell]]()
for i in 0...250000 {
    let game1 = Game(wizard: Wizard(hitPoints: 50, mana: 500, spellbook: allSpells), boss: Boss(hitPoints: 55, damage: 8))
    let result = game1.playRandomGame()
    if result.won {
        results.append(result.spells)
    }
}

print ("Won \(results.count) games")

if results.count > 0 {
    let summed = results.map { (mana: $0.reduce(0) { $0 + $1.manaCosts}, spells: $0) }
    let sorted = summed.sorted { $0.mana < $1.mana }
    let cheapest = sorted.first!
    print ("The 'cheapest' one, costed \(cheapest.mana) mana and used these spells:")
    print (cheapest.spells.map { $0.title }.joined(separator: "\n"))
}

