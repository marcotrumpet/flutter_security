//
//  helper_methods.swift
//  flutter_security
//
//  Created by Marco Galetta on 30/11/21.
//

import CryptoKit
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

@available(iOS 13.0, *)
func getMD5(bytes: [UInt8]) -> String {
    
    return Insecure.MD5.hash(data: bytes).map {String(format: "%02hhx", $0)}.joined()
    
}

func getUint8ArrayFromFile(path: String) -> [UInt8] {
    var bytes = [UInt8]()
    
    if let data = NSData(contentsOfFile: path) {
        
        var buffer: [UInt8] = [UInt8](repeating: 0,count: data.length)
        data.getBytes(&buffer, length: data.length)
        bytes = buffer
    }
    
    return bytes
}

struct JsonField : Decodable {
    var path: String
    var hash: String
    
    var asDictionary: [String: String] {
        return [
            "path": path,
            "hash": hash,
        ]
    }
}
