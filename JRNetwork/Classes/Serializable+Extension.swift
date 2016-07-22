//
//  Serializable+Extension.swift
//  Pods
//
//  Created by 王小涛 on 16/6/12.
//
//

import Foundation

extension String: ResponseObjectSerializable {
    
    public static func object(response response: NSHTTPURLResponse, representation: AnyObject) -> String? {
        return representation as? String
    }
}

extension Int: ResponseObjectSerializable {
    
    public static func object(response response: NSHTTPURLResponse, representation: AnyObject) -> Int? {
        return representation as? Int
    }
}
