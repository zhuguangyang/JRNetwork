//
//  APIError.swift
//  Pods
//
//  Created by 王小涛 on 16/6/12.
//
//

import Foundation

public struct APIError: ErrorType {
    
    public let error: NSError
    public let object: AnyObject?
    
    public init(error: NSError, object: AnyObject? = nil) {
        
        self.error = error
        self.object = object
    }
}


