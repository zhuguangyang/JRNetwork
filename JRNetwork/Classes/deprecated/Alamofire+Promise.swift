////
////  Alamofire+Promise.swift
////  Pods
////
////  Created by 王小涛 on 16/6/17.
////
////
//
//import Alamofire
//
//public extension Alamofire.Request {
//
//    func promiseJSON(keyPath: String? = nil) -> Promise<AnyObject, APIError> {
//        
//        return Promise<AnyObject, APIError> { completion in
//            self.responseJSON(keyPath, completed: { result in
//                completion(result)
//            })
//        }
//    }
//}
//
//public extension Alamofire.Request {
//    
//    func promiseObject<T: ResponseObjectSerializable>(keyPath: String? = nil) -> Promise<T, APIError> {
//        
//        return Promise<T, APIError> { completion in
//            self.responseObject(keyPath, completed: { result in
//                completion(result)
//            })
//        }
//    }
//}
//
//public extension Alamofire.Request {
//    
//    func promiseCollection<T: ResponseCollectionSerializable>(keyPath: String? = nil) -> Promise<[T], APIError> {
//        
//        return Promise<[T], APIError> { completion in
//            self.responseCollection(keyPath, completed: { result in
//                completion(result)
//            })
//        }
//    }
//}
//
//
