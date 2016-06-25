////
////  Requestable.swift
////  Pods
////
////  Created by 王小涛 on 16/6/24.
////
////
//
//import Alamofire
//
//public class JRRequest {
//    
//    private let manager: Alamofire.Manager = Manager.sharedInstance
//    private let request: Request
//    
//    public init(endPoint: URLRequestCachable) {
//        self.request = manager.request(endPoint)
//    }
//    
//    public func responseObject<T: ResponseObjectSerializable>(keyPath: String?, completed: Result<T, APIError> -> Void) {
//        
//        // cancel previous request
//        cancel()
//        
//        request.responseObject(keyPath, completed: completed)
//    }
//    
//    public func cancel() {
//        request.cancel()
//    }
//}
//
//
