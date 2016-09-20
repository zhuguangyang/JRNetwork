////
////  Alamofire+PromiseKit.swift
////  Pods
////
////  Created by 王小涛 on 16/6/22.
////
////
//
//import Alamofire
//import PromiseKit
//
//
//public extension Alamofire.Request {
//    
//    func promiseObject<T: ResponseObjectSerializable>(keyPath: String? = nil) -> Promise<T> {
//        
//        return Promise(resolvers: { (fulfill, reject) in
//            
//            responseObject(keyPath: keyPath, completionHandler: { (response: Response<T, BackendError>) in
//                
//                switch response.result {
//                case let.Success(value):
//                    fulfill(value)
//                case let .Failure(error):
//                    reject(error)
//                }
//            })
//        })
//    }
//}
//
//public extension Alamofire.Request {
//    
//    func promiseCollection<T: ResponseCollectionSerializable>(keyPath: String? = nil) -> Promise<[T]> {
//        
//        return Promise(resolvers: { (fulfill, reject) in
//            
//            responseCollection(keyPath: keyPath, completionHandler: { (response: Response<[T], BackendError>) in
//                
//                switch response.result {
//                case let.Success(value):
//                    fulfill(value)
//                case let .Failure(error):
//                    reject(error)
//                }
//            })
//        })
//    }
//}
//
//
//
//
//
