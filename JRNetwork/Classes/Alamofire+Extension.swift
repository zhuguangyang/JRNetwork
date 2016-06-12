//
//  Alamofire+Extension.swift
//  Pods
//
//  Created by 王小涛 on 16/6/12.
//
//

import Alamofire

public extension Alamofire.Request {
    
    func responseJSON(keyPath: String?, completed: APIResult<AnyObject> -> Void) {
        
        responseJSON { (response) in
            
            switch response.result {
            case let .Success(value):
                
                if let JSONToSerialize = keyPath == nil ? value : value.valueForKeyPath(keyPath!) {
                    completed(.Success(value))
                } else {
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: "JSON in keyPath \(keyPath) not found: \(value)")
                    completed(.Failure(error, value))
                }
               
            case let .Failure(error):
                completed(.Failure(error, nil))
            }
        }
    }
}


