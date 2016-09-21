//
//  Serializable+Extension.swift
//  Pods
//
//  Created by 王小涛 on 16/9/19.
//
//

import Foundation

extension Int: ResponseObjectSerializable {
    
    public static func object(from response: NSHTTPURLResponse, withRepresentation representation: AnyObject) -> Int? {
    
        return representation as? Int
    }
}

extension Int: ResponseCollectionSerializable {}


extension String: ResponseObjectSerializable {

    public static func object(from response: NSHTTPURLResponse, withRepresentation representation: AnyObject) -> String? {
        
        return representation as? String
    }
}

extension String: ResponseCollectionSerializable {}


