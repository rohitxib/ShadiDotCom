//
//  CodableExtn.swift
//  ShadiDotCom
//
//  Created by Rohit on 16/01/25.
//

import Foundation
extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    var toString : String? {
        guard let encodedString = try? JSONEncoder().encode(self) else { return nil }
        if let returnString = String(data: encodedString, encoding: .utf8) {
            return returnString
        } else {
            return nil
        }
    }
}
