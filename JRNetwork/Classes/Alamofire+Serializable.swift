//
//  Alamofire+Serializable.swift
//  Pods
//
//  Created by 王小涛 on 16/6/12.
//
//

import Alamofire

extension Alamofire.Request {
    
    func objectResponseSerializer<T: ResponseObjectSerializable>(keyPath keyPath: String?) -> ResponseSerializer<T, BackendError> {
        
        return ResponseSerializer { request, response, data, error in
            
            guard error == nil else {
                return .Failure(.Network(error: error!))
            }

            let jsonResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            

            switch result {
                
            case let .Success(value):
                
                guard let JSON = keyPath == nil ? value : value.valueForKeyPath(keyPath!) else {
                    
                    return .Failure(.ObjectSerialization(reason: "JSON for keyPath(\(keyPath == nil ? "" : keyPath!)) not exist: \(value)", object: value))
                }
                
                guard let response = response,
                    let responseObject = T(response: response, representation: JSON) else {
                    
                        return .Failure(.ObjectSerialization(reason: "JSON for keyPath(\(keyPath == nil ? "" : keyPath!)) could not be serialized into response object: \(value)", object: value))
                }
                
                return .Success(responseObject)
                
            case let .Failure(error):
                
                return .Failure(.JSONSerialization(error: result.error!))

            }
        }
    }
    
    public func responseObject<T: ResponseObjectSerializable>(queue queue: dispatch_queue_t? = nil,
                            keyPath: String? = nil,
                            completionHandler: Response<T, BackendError> -> Void) -> Self {
        
        return response(
            queue: queue,
            responseSerializer: objectResponseSerializer(keyPath: keyPath),
            completionHandler: completionHandler
        )
    }
}

extension Alamofire.Request {
    
    func collectionResponseSerializer<T: ResponseCollectionSerializable>(keyPath keyPath: String?) -> ResponseSerializer<[T], BackendError> {
        
        return ResponseSerializer { request, response, data, error in
            
            guard error == nil else {
                return .Failure(.Network(error: error!))
            }

            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
                
            case let .Success(value):
                
                guard let JSON = keyPath == nil ? value : value.valueForKeyPath(keyPath!) else {
                    
                    return .Failure(.ObjectSerialization(reason: "JSON for keyPath(\(keyPath == nil ? "" : keyPath!)) not exist: \(value)", object: value))
                }
                
                guard let response = response,
                    let responseObject = T.collection(from: response, withRepresentation: JSON) else {
                        
                        return .Failure(.ObjectSerialization(reason: "JSON for keyPath(\(keyPath == nil ? "" : keyPath!)) could not be serialized into response object: \(value)", object: value))
                }
                
                return .Success(responseObject)
                
            case let .Failure(error):
                
                return .Failure(.JSONSerialization(error: error))
            }
        }
    }
    
    public func responseCollection<T: ResponseCollectionSerializable>(queue queue: dispatch_queue_t? = nil,
                        options: NSJSONReadingOptions = .AllowFragments,
                        keyPath: String? = nil,
                        completionHandler: Response<[T], BackendError> -> Void) -> Self {
        
        return response(
            queue: queue,
            responseSerializer: collectionResponseSerializer(keyPath: keyPath),
            completionHandler: completionHandler
        )
    }
}



