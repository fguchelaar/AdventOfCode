//: # Advent of Code - [Day 13](http://adventofcode.com/day/13)
import Foundation

var input = ""
//var input = try String(contentsOfURL:[#FileReference(fileReferenceLiteral: "input.txt")#])
//var input = try String(contentsOfURL:[#FileReference(fileReferenceLiteral: "example.txt")#])

var rules = input.components(separatedBy: .newlines).map {$0.trimmingCharacters(in: CharacterSet(charactersIn: "."))}

struct Seating {
    var name1 : String
    var name2 : String
}

extension Seating : Equatable {}
func ==(lhs: Seating, rhs: Seating) -> Bool {
    return lhs.name1 == rhs.name1 && lhs.name2 == rhs.name2
}

extension Seating : Hashable {
    var hashValue : Int {
        return (name1+name2).hashValue
    }
}

var happiness = [Seating: Int]()
var people = Set<String>()

for rule in rules {
    var parts = rule.components(separatedBy: " ")
    let key = Seating(name1: parts[0], name2: parts[10])
    let value = Int(parts[3])! * (parts[2] == "lose" ? -1 : 1)
    happiness[key] = value
    people.insert(key.name1)
    people.insert(key.name2)
}

// Add myself to the party, for Part Two
for person in people {
    happiness[Seating(name1: "Me", name2: person)] = 0
    happiness[Seating(name1: person, name2: "Me")] = 0
}
people.insert("Me")

print(people)

//

var sortedPeople = MyArray(array: people.sorted())
var permutations = sortedPeople.permutations(1)

var maxHappiness = -1

for perm in permutations {
    var happy = 0
    for seating in perm.enumerated() {
        
        let left = Seating(name1: seating.element, name2: perm[(seating.index-1 + perm.count) % perm.count])
        let right = Seating(name1: seating.element, name2: perm[(seating.index+1 + perm.count) % perm.count])

        happy += happiness[left] ?? 0
        happy += happiness[right] ?? 0
    }
    if(happy > maxHappiness) {
        maxHappiness = max(happy, maxHappiness)
        print("\(maxHappiness) \t\(perm)")
    }
}

print("Optimal total change of happiness: \(maxHappiness)")
