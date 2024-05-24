import Foundation
import CommonCrypto

// Function to compute the MD5 hash of a given string
func md5(_ input: String) -> String {
    let data = Data(input.utf8)
    var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
    
    _ = data.withUnsafeBytes {
        CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
    }
    
    return digest.map { String(format: "%02hhx", $0) }.joined()
}

// Function to find the lowest number that produces an MD5 hash starting with five zeroes
func findAdventCoin(secretKey: String) -> Int {
    var number = 1
    while true {
        let combined = "\(secretKey)\(number)"
        let hash = md5(combined)
        if hash.hasPrefix("00000") {
            return number
        }
        number += 1
    }
}

// Puzzle input
let secretKey = "yzbqklnj"

// Find and print the solution
let result = findAdventCoin(secretKey: secretKey)
print("The lowest positive number is \(result)")

