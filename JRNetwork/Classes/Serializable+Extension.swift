//
//  Serializable+Extension.swift
//  Pods
//
//  Created by 王小涛 on 16/6/12.
//
//

import Foundation

extension String: ResponseObjectSerializable {
    
    public static func object(JSON: AnyObject) -> String? {
        return JSON as? String
    }
}

extension Int: ResponseObjectSerializable {
    
    public static func object(JSON: AnyObject) -> Int? {
        return JSON as? Int
    }
}


