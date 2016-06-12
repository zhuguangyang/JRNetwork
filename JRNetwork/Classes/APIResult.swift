//
//  APIResult.swift
//  Pods
//
//  Created by 王小涛 on 16/6/12.
//
//

import Foundation

public enum APIResult<T> {
    
    case Success(T)
    case Failure(NSError, AnyObject?)
}

public extension APIResult {

    func map<U>(@noescape f: T->U) -> APIResult<U> {
        switch self {
        case let .Success(value):
            return APIResult<U>.Success(f(value))
        case let .Failure(error, object):
            return APIResult<U>.Failure(error, object)
        }
    }
    
    func flatMap< U>(@noescape f: T -> APIResult<U>) -> APIResult<U> {
        return APIResult.flatten(map(f))
    }
}

private extension APIResult {
    
    static func flatten<T>(result: APIResult<APIResult<T>>) -> APIResult<T> {
        switch result {
        case let .Success(value):
            return value
        case let .Failure(error, object):
            return .Failure(error, object)
        }
    }
}


