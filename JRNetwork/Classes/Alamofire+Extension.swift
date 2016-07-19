//
//  Alamofire+Extension.swift
//  Pods
//
//  Created by 王小涛 on 16/6/12.
//
//

import Alamofire

public extension Alamofire.Request {
    
    static func JSONResponseSerializer(options options: NSJSONReadingOptions = .AllowFragments,
                keyPath: String?) -> ResponseSerializer<AnyObject, APIError> {
        
        return ResponseSerializer { request, response, data, error in
            
            let serializer = JSONResponseSerializer(options: options)
            
            let result = serializer.serializeResponse(request, response, data, error)
            
            switch result {

            case let .Success(value):

                if let JSON = keyPath == nil ? value : value.valueForKeyPath(keyPath!) {
                    return .Success(JSON)
                } else {
                    let error = NSError(domain: Error.Domain, code: Error.Code.JSONSerializationFailed.rawValue, userInfo: [NSLocalizedFailureReasonErrorKey: "JSON in keyPath \(keyPath) not found: \(value)"])
                    return .Failure(APIError(error: error, object: value))
                }

            case let .Failure(error):
                
                return .Failure(APIError(error: error))
            }
        }
    }
    
    func responseJSON(queue queue: dispatch_queue_t? = nil,
              options: NSJSONReadingOptions = .AllowFragments,
              keyPath: String? = nil,
              completionHandler: Response<AnyObject, APIError> -> Void) -> Self {
            
        return response(
            queue: queue,
            responseSerializer: Request.JSONResponseSerializer(options: options, keyPath: keyPath),
            completionHandler: completionHandler
        )
    }
}



