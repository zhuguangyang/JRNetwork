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
    
    static func ObjectResponseSerializer<T: ResponseObjectSerializable>(keyPath keyPath: String?) -> ResponseSerializer<T, APIError> {
        
        return ResponseSerializer { request, response, data, error in
            
            let serializer = JSONResponseSerializer(options: .AllowFragments, keyPath: keyPath)
            
            let result = serializer.serializeResponse(request, response, data, error)
            
            let newResult = result.flatMap({ (value) -> Result<T, APIError> in
                
                if let object = T.object(value) {
                    return .Success(object)
                } else {
                    let error = NSError(domain: Error.Domain, code: Error.Code.JSONSerializationFailed.rawValue, userInfo: [NSLocalizedFailureReasonErrorKey: "JSON could not be serialized into response object: \(value)"])
                    return .Failure(APIError(error: error, object: value))
                }
            })
            
            return newResult
        }
    }
    
    func responseObject<T: ResponseObjectSerializable>(queue queue: dispatch_queue_t? = nil,
                            options: NSJSONReadingOptions = .AllowFragments,
                            keyPath: String? = nil,
                            completionHandler: Response<T, APIError> -> Void) -> Self {
        
        return response(
            queue: queue,
            responseSerializer: Request.ObjectResponseSerializer(keyPath: keyPath),
            completionHandler: completionHandler
        )
    }
}


public protocol ResponseCollectionSerializable {
    @warn_unused_result
    static func collection(JSON: AnyObject) -> [Self]?
}


public extension Alamofire.Request {
    
    static func CollectionResponseSerializer<T: ResponseCollectionSerializable>(keyPath keyPath: String?) -> ResponseSerializer<[T], APIError> {
        
        return ResponseSerializer { request, response, data, error in
            
            let serializer = JSONResponseSerializer(options: .AllowFragments, keyPath: keyPath)
            
            let result = serializer.serializeResponse(request, response, data, error)
            
            let newResult = result.flatMap({ (value) -> Result<[T], APIError> in

                if let collection = T.collection(value) {
                    return .Success(collection)
                } else {
                    let error = NSError(domain: Error.Domain, code: Error.Code.JSONSerializationFailed.rawValue, userInfo: [NSLocalizedFailureReasonErrorKey: "JSON could not be serialized into response collection: \(value)"])
                    return .Failure(APIError(error: error, object: value))
                }
            })
            return newResult
        }
    }
    
    func responseCollection<T: ResponseCollectionSerializable>(queue queue: dispatch_queue_t? = nil,
                        options: NSJSONReadingOptions = .AllowFragments,
                        keyPath: String? = nil,
                        completionHandler: Response<[T], APIError> -> Void) -> Self {
        
        return response(
            queue: queue,
            responseSerializer: Request.CollectionResponseSerializer(keyPath: keyPath),
            completionHandler: completionHandler
        )
    }
}





