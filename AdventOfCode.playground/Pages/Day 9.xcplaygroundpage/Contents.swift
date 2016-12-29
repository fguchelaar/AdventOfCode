//: # Advent of Code - [Day 9](http://adventofcode.com/day/9)
import Foundation

var input = try String(contentsOf:#fileLiteral(resourceName: "input.txt"))
var routes = input.components(separatedBy: .newlines)

var cities = Set<String>()
var distances = Dictionary<String, Int>()

// distances are symetric, so for convenience I'll add both directions
for route in routes {
    var parts = route.components(separatedBy: " ")
    var city1 = parts[0]
    var city2 = parts[2]
    var distance = Int(parts[4])
    
    cities.insert(city1)
    cities.insert(city2)
    
    distances["\(city1)\(city2)"] = distance
    distances["\(city2)\(city1)"] = distance
}


var shortestPath = Int.max
var longestPath = Int.min
var used = Array<Bool>(repeating: false, count: cities.count)

func traverse(_ theCities: Array<String>, index : Int, pathSofar : Array<String>, distanceSofar : Int) {
    var path = pathSofar

//    if(distanceSofar < longestPath) {
//        return
//    }

    if (index == cities.count) {
        if (distanceSofar > longestPath) {
            longestPath = distanceSofar
            print("√ \(distanceSofar) (\(path.count))\t\(path)")
        }
    }
    else {
        for i in 0..<theCities.count {

            if (!used[i]) {
                var distance = 0
                if pathSofar.count != 0 {
                    let route = "\(path.last!)\(theCities[i])"
                    if distances.keys.contains(route) {
                        distance = distances[route]!
                    }
                }
                
                used[i] = true
                path.append(theCities[i])
                traverse(theCities, index: index+1, pathSofar: path, distanceSofar: distanceSofar + distance)
                path.removeLast()
                used[i] = false
            }
        }
    }
}

traverse(cities.sorted(), index: 0, pathSofar: Array<String>(), distanceSofar: 0)
