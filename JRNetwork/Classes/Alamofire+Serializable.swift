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

            guard case let .Success(value) = result else {
                return .Failure(.JSONSerialization(error: result.error!))
            }
            
            var jsonCandidate: Any? {
                var json: Any?
                if let keyPath = keyPath where !keyPath.isEmpty {
                    json = value.valueForKeyPath(keyPath)
                } else {
                    json = value
                }
                return json
            }
            
            guard let json = jsonCandidate else {
                return .Failure(.ObjectSerialization(reason: "jsonCandidate is nil", object: value))
            }
            
            guard let responseObject = T(json: json) else {
                return .Failure(.ObjectSerialization(reason: "jsonCandidate can not serialize", object: value))
            }
            
            return .Success(responseObject)
        }
    }
    
    public func response<T: ResponseObjectSerializable>(queue queue: dispatch_queue_t? = nil,
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
    
    func arrayResponseSerializer<T: ResponseObjectSerializable>(keyPath keyPath: String?) -> ResponseSerializer<[T], BackendError> {
        
        return ResponseSerializer { request, response, data, error in
            
            guard error == nil else {
                return .Failure(.Network(error: error!))
            }

            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            
            
            guard case let .Success(value) = result else {
                return .Failure(.JSONSerialization(error: result.error!))
            }
            
            var jsonCandidate: Any? {
                var json: Any?
                if let keyPath = keyPath where !keyPath.isEmpty {
                    json = value.valueForKeyPath(keyPath)
                } else {
                    json = value
                }
                return json
            }
            
            
            guard let json = jsonCandidate as? [Any] else {
                return .Failure(.ObjectSerialization(reason: "jsonCandidate is not a [Any] value", object: value))
            }
            
            func array<T: ResponseObjectSerializable>(json: [Any]) -> [T] {
                return json.reduce([], combine: { (container, rawValue) in
                    if let value = T(json: rawValue) {
                        return container + [value]
                    }else {
                        return container
                    }
                })
            }
            
            return .Success(array(json))
        }
    }
    
    public func response<T: ResponseObjectSerializable>(queue queue: dispatch_queue_t? = nil,
                        options: NSJSONReadingOptions = .AllowFragments,
                        keyPath: String? = nil,
                        completionHandler: Response<[T], BackendError> -> Void) -> Self {
        
        return response(
            queue: queue,
            responseSerializer: arrayResponseSerializer(keyPath: keyPath),
            completionHandler: completionHandler
        )
    }
}



