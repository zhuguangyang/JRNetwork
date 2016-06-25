//
//  APIError.swift
//  Pods
//
//  Created by 王小涛 on 16/6/12.
//
//

import Foundation

public struct APIError: ErrorType {
    
    let error: NSError
    let object: AnyObject?
    
    init(error: NSError, object: AnyObject? = nil) {
        
        self.error = error
        self.object = object
    }
}


