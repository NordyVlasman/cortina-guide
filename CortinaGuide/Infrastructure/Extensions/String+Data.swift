//
//  String+Data.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation
import CommonCrypto

extension String {
    
    var sha256: String {
        
        let str = cString(using: .utf8)
        let strLen = CUnsignedInt(lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)

        CC_SHA256(str, strLen, result)

        let hash = NSMutableString()
        
        for index in 0 ..< digestLen {
            hash.appendFormat("%02x", result[index])
        }

        result.deallocate()

        return String(format: hash as String)
    }
}
