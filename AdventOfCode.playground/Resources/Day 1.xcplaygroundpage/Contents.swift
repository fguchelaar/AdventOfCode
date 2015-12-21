

import UIKit

var input = try String(contentsOfURL:[#FileReference(fileReferenceLiteral: "input.txt")#])

var chars = Array(input.characters)

var floor = chars.map { (Character) -> Int in
    switch (Character) {
    case "(":
        return 1
    case ")":
        return -1
    default:
        return 0
    }
}.reduce(0, combine: +)