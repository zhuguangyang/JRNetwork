//
//  Alamofire+PromiseKit.swift
//  Pods
//
//  Created by 王小涛 on 16/6/22.
//
//

import Alamofire
import PromiseKit

public extension Alamofire.Request {
    
    func promiseJSON(keyPath: String? = nil) -> Promise<AnyObject> {
        
        return Promise(resolvers: { (fulfill, reject) in
            
            self.responseJSON(keyPath, completed: { result in
                
                switch result {
                case let.Success(value):
                    fulfill(value)
                case let .Failure(error):
                    reject(error)
                }
            })
        })
    }
}

public extension Alamofire.Request {
    
    func promiseObject<T: ResponseObjectSerializable>(keyPath: String? = nil) -> Promise<T> {
        
        return Promise(resolvers: { (fulfill, reject) in
            
            self.responseObject(completed: { (result: Result<T, APIError>) in
                
                switch result {
                case let.Success(value):
                    fulfill(value)
                case let .Failure(error):
                    reject(error)
                }
            })
        })
    }
}

public extension Alamofire.Request {
    
    func promiseCollection<T: ResponseCollectionSerializable>(keyPath: String? = nil) -> Promise<[T]> {
        
        return Promise(resolvers: { (fulfill, reject) in
            
            self.responseCollection(completed: { (result: Result<[T], APIError>) in
                
                switch result {
                case let.Success(value):
                    fulfill(value)
                case let .Failure(error):
                    reject(error)
                }
            })
        })
    }
}





