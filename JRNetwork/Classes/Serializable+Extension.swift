//
//  Serializable+Extension.swift
//  Pods
//
//  Created by 王小涛 on 16/9/19.
//
//

import Foundation

extension Int: ResponseObjectSerializable {
    
    public init?(response: NSHTTPURLResponse, representation: AnyObject) {
        
        guard let int = representation as? Int else {return nil}
        self = int
    }
}

extension Int: ResponseCollectionSerializable {}


extension String: ResponseObjectSerializable {

    public init?(response: NSHTTPURLResponse, representation: AnyObject) {
        
        guard let string = representation as? String else {return nil}
        self = string
    }
}

extension String: ResponseCollectionSerializable {}


