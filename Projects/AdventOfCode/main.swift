//
//  main.swift
//  AdventOfCode
//
//  Created by Frank Guchelaar on 21-12-15.
//  Copyright © 2015 Frank Guchelaar. All rights reserved.
//

import Foundation

// Day 4
//import CommonCrypto
//
//extension String {
//    
//    func hnk_MD5String() -> String {
//        if let data = self.dataUsingEncoding(NSUTF8StringEncoding)
//        {
//            let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))
//            let resultBytes = UnsafeMutablePointer<CUnsignedChar>(result!.mutableBytes)
//            CC_MD5(data.bytes, CC_LONG(data.length), resultBytes)
//            let resultEnumerator = UnsafeBufferPointer<CUnsignedChar>(start: resultBytes, count: result!.length)
//            let MD5 = NSMutableString()
//            for c in resultEnumerator {
//                MD5.appendFormat("%02x", c)
//            }
//            return MD5 as String
//        }
//        return ""
//    }
//}
//
//var secretKey = "bgvyzdsv"
//
//var salt = 0;
//while(true) {
//    
//    let md5 = secretKey.stringByAppendingString("\(salt)").hnk_MD5String()
//    
//    if md5.hasPrefix("000000") {
//        print("\(md5) >> \(salt)")
//        break;
//    }
//    
//    salt++
//}
//

// Day 11
var input = "hxbxxyzz"

extension String {
    
    func next() -> String {
        
        var shouldIncrement = true
        var scalars = String.UnicodeScalarView()
        
        for c in unicodeScalars.reversed() {
            if (shouldIncrement) {
                var newValue = c.value >= 122 ? 97 : c.value + UInt32(1)
                
                if newValue == 105 || newValue == 108 || newValue == 111 {
                    newValue += 1
                }
                
                scalars.append(UnicodeScalar(newValue)!)
                shouldIncrement = newValue == 97
            }
            else {
                scalars.append(c)
            }
        }
        if (shouldIncrement) {
            return "aaaaaaaa"
        }
        return String(String(scalars).characters.reversed())
        
    }
    
    func containsStraight() -> Bool {
        for index in unicodeScalars.startIndex...unicodeScalars.index(unicodeScalars.endIndex, offsetBy: -2) {
            if unicodeScalars[index].value == (unicodeScalars[<#T##String.UnicodeScalarView corresponding to `index`##String.UnicodeScalarView#>.index(after: index)].value-1)
                && unicodeScalars[index].value == (unicodeScalars[<#T##Collection corresponding to your index##Collection#>.index(after: <#T##String.UnicodeScalarView corresponding to `index`##String.UnicodeScalarView#>.index(after: index))].value-2) {
                    return true
            }
        }
        return false
    }
    
    func containsDoubleNonOverlappingTwoCharacters() -> Bool {
        var tuples = Set<String>()
       
        for index in startIndex...characters.index(endIndex, offsetBy: -2) {
            let tuple = substring(with: (index ..< <#T##String.CharacterView corresponding to `index`##String.CharacterView#>.index(index, offsetBy: 2)))
            if tuple.characters[tuple.startIndex]==tuple.characters[tuple.characters.index(before: tuple.endIndex)] {
                tuples.insert(tuple)
            }
        }
        
        return tuples.count > 1
    }
    
    func containsIllegalCharacters() -> Bool {
        for illegalCharacter in ["i", "o", "l"] {
            if contains(illegalCharacter){
                return true
            }
        }
        return false
    }
    
    func isValid() -> Bool {
        return !containsIllegalCharacters()
            && containsStraight()
            && containsDoubleNonOverlappingTwoCharacters();
    }
}

input = input.next()
while (!input.isValid()) {
    input = input.next()
    print(input)
}
