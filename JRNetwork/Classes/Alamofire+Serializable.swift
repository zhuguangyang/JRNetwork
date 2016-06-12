//
//  Alamofire+Serializable.swift
//  Pods
//
//  Created by 王小涛 on 16/6/12.
//
//

import Alamofire

public protocol ResponseObjectSerializable {
    @warn_unused_result
    static func object(JSON: AnyObject) -> Self?
}

public extension Alamofire.Request {
    
    func responseObject<T: ResponseObjectSerializable>(keyPath: String? = nil, completed: APIResult<T> -> Void) {
        
        responseJSON(keyPath) { (result) in
            
            let newResult = result.flatMap({ (value) -> APIResult<T> in
                
                if let object = T.object(value)
                {
                    return .Success(object)
                } else {
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: "JSON could not be serialized into response object: \(value)")
                    return .Failure(error, value)
                }
            })
            completed(newResult)
        }
    }
}


public protocol ResponseCollectionSerializable {
    @warn_unused_result
    static func collection(JSON: AnyObject) -> [Self]?
}


public extension Alamofire.Request {
    
    func responseCollection<T: ResponseCollectionSerializable>(keyPath: String? = nil, completed: APIResult<[T]> -> Void) {
        
        responseJSON(keyPath) { (result) in
            
            let newResult = result.flatMap({ (value) -> APIResult<[T]> in
                
                if let collection = T.collection(value)
                {
                    return .Success(collection)
                } else {
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: "JSON could not be serialized into response collection: \(value)")
                    return .Failure(error, value)
                }
            })
            completed(newResult)
        }
    }
}


