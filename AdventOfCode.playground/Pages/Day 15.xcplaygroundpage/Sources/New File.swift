import Foundation

public class Helper {
    
    var input : String
    
    public init(input : String) {
        self.input = input
    }
    
    public func combos() -> [(a: Int, b: Int, c: Int, d: Int)] {
        var combos = Array<(a: Int, b: Int, c: Int, d: Int)>()
        
        for a in 0...100 {
            for b in 0...100 {
                for c in 0...100 {
                    for d in 0...100 {
                        if a+b+c+d == 100 {
                            combos.append((a, b, c, d))
                        }
                    }}}}
        return combos
    }
    
    
    // http://stackoverflow.com/questions/25162500/apple-swift-generate-combinations-with-repetition
    public func combos<T>(let array: Array<T>, k: Int) -> Array<Array<T>> {
        if k == 0 {
            return [[]]
        }
        
        if array.isEmpty {
            return []
        }
        
        let head = [array[0]]
        let subcombos = combos(array, k: k - 1)
        var ret = subcombos.map {head + $0}
        ret += combos(Array(array.dropFirst(1)), k: k)
        
        return ret
    }
    
    struct Ingredient {
        var name : String
        var capacity : Int
        var durability : Int
        var flavor : Int
        var texture : Int
        var calories : Int
        func scoreForAmount(amount : Int) -> (capacity : Int, durability: Int, flavor: Int, texture: Int, calories: Int) {
            return (capacity * amount, durability * amount, flavor * amount, texture * amount, calories * amount)
        }
    }
    
    var ingredients = [Ingredient]()
    
    public func solve() {
        for var ingredient in input.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) {
            ingredient = ingredient.stringByReplacingOccurrencesOfString(":", withString: "")
            ingredient = ingredient.stringByReplacingOccurrencesOfString(",", withString: "")

            var parts = ingredient.componentsSeparatedByCharactersInSet(.whitespaceCharacterSet())
            ingredients.append(Ingredient(name: parts[0],
                capacity: Int(parts[2])!,
                durability: Int(parts[4])!,
                flavor: Int(parts[6])!,
                texture: Int(parts[8])!,
                calories: Int(parts[10])!))
        }
        print(ingredients)
        
        let combos = self.combos()
        
        var maxScore = -1
        for combo in combos {
            let scoreA = ingredients[0].scoreForAmount(combo.a)
            let scoreB = ingredients[1].scoreForAmount(combo.b)
            let scoreC = ingredients[2].scoreForAmount(combo.c)
            let scoreD = ingredients[3].scoreForAmount(combo.d)
            
            let s1 = max(0, scoreA.capacity + scoreB.capacity + scoreC.capacity + scoreD.capacity)
            let s2 = max(0, scoreA.durability + scoreB.durability + scoreC.durability + scoreD.durability)
            let s3 = max(0, scoreA.flavor + scoreB.flavor + scoreC.flavor + scoreD.flavor)
            let s4 = max(0, scoreA.texture + scoreB.texture + scoreC.texture + scoreD.texture)
            let s5 = max(0, scoreA.calories + scoreB.calories + scoreC.calories + scoreD.calories)
            
            let score = s1*s2*s3*s4
            
            // For part two, the s5==500 was added
            if s5 == 500 && score > maxScore {
                maxScore = score
                print("\(combo) \t\(score) \t(\(s5))")
            }
        }
    }
}