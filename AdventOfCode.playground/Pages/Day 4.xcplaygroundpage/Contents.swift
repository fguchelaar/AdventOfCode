//: # Advent of Code - [Day 4](http://adventofcode.com/day/4)
//: MD5 hashing is not quite accessible from a playground, therefor I've coded this one in 
//: a simple OS X Console App

/*
import Foundation
import CommonCrypto

extension String {

    func hnk_MD5String() -> String {
        if let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        {
            let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))
            let resultBytes = UnsafeMutablePointer<CUnsignedChar>(result!.mutableBytes)
            CC_MD5(data.bytes, CC_LONG(data.length), resultBytes)
            let resultEnumerator = UnsafeBufferPointer<CUnsignedChar>(start: resultBytes, count: result!.length)
            let MD5 = NSMutableString()
            for c in resultEnumerator {
                MD5.appendFormat("%02x", c)
            }
            return MD5 as String
        }
        return ""
    }
}

var secretKey = "bgvyzdsv"

var salt = 0;
while(true) {

    let md5 = secretKey.stringByAppendingString("\(salt)").hnk_MD5String()

    if md5.hasPrefix("000000") {
        print("\(md5) >> \(salt)")
        break;
    }

    salt++
}
*/
