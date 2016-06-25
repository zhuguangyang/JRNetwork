////
////  AdditiveCollection.swift
////  Pods
////
////  Created by 王小涛 on 16/6/24.
////
////
//
//import Alamofire
//
//public protocol URLRequestNextable: URLRequestCachable {
//    
//    func next() -> Self
//    func first() -> Self
//    var isFirst: Bool { get }
//}
//
//public struct AdditiveCollectionRequest {
//    
//    private var endPoint: URLRequestNextable
//    
//    public init(endPoint: URLRequestNextable) {
//        self.endPoint = endPoint
//    }
//    
//    public mutating func response<T: ResponseCollectionSerializable>(completed: (Result<[T], APIError>, Bool) -> Void) {
//        
//        request(endPoint).responseCollection { (result: Result<[T], APIError>) in
//            
//            completed(result, self.endPoint.isFirst)
//            
//            if case let .Success = result {
//                self.endPoint = self.endPoint.next()
//            }
//        }
//    }
//}
