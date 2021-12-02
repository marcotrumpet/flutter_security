//
//  helper_methods.swift
//  flutter_security
//
//  Created by Marco Galetta on 30/11/21.
//

import CryptoKit
import Foundation

@available(iOS 13.0, *)
func getMD5(string: String) -> String {
    
    let messageData = string.data(using: .utf8)!
    return Insecure.MD5.hash(data: messageData).map {String(format: "%02hhx", $0)}
    .joined()

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
