//
//  Serializable+Extension.swift
//  Pods
//
//  Created by 王小涛 on 16/9/19.
//
//

import Foundation

extension Int: ResponseObjectSerializable {
    
    public init?(from response: NSHTTPURLResponse, withRepresentation representation: AnyObject) {
        
        if let object = representation as? Int {
            self = object
        }else {
            return nil
        }
    }
}

extension Int: ResponseCollectionSerializable {}


extension String: ResponseObjectSerializable {

    public init?(from response: NSHTTPURLResponse, withRepresentation representation: AnyObject) {
        
        if let object = representation as? String {
            self = object
        }else {
            return nil
        }
    }
}




extension String: ResponseCollectionSerializable {}


