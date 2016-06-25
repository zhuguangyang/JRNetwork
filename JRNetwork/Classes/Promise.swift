////
////  Promise.swift
////  Pods
////
////  Created by 王小涛 on 16/6/17.
////
////
//
//import Alamofire
//
//public struct Promise<T, E: ErrorType> {
//    
//    public typealias ResultType = Result<T, E>
//    public typealias Completion = ResultType -> Void
//    public typealias AsyncOperation = Completion -> Void
//
//    private let operation: AsyncOperation
//    
//    public init(operation: AsyncOperation) {
//        self.operation = operation
//    }
//    
//    public func start(completion: Completion) -> Promise {
//        
//        self.operation { result in
//            completion(result)
//        }
//        return self
//    }
//}
//
//public extension Promise {
//    // 与 map 对应的 monad，在 Promise 通常被称为 then
//    func then<U>(f: T -> U) -> Promise<U, E> {
//        
//        return Promise<U, E>(operation: { completion in
//            
//            self.start({ result in
//                
//                switch result {
//                case let .Success(value):
//                    completion(.Success(f(value)))
//                case let .Failure(error):
//                    completion(.Failure(error))
//                }
//            })
//        })
//    }
//    
//    // 与 flatMap 对应的 monad，在 Promise 中也被称为 then
//    func then<U>(f: T -> Promise<U, E>) -> Promise<U, E> {
//        
//        return Promise<U, E> { completion in
//            
//            self.start({ result in
//                
//                switch result {
//                case let .Success(value):
//                    f(value).start(completion)
//                case let .Failure(error):
//                    completion(.Failure(error))
//                }
//            })
//        }
//    }
//}
//
//public extension Promise {
//
//    func finally(completion: Completion) {
//        start(completion)
//    }
//}
//
//
//
