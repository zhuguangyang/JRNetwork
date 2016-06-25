//
//  Result+Extension.swift
//  Pods
//
//  Created by 王小涛 on 16/6/17.
//
//

import Alamofire

public extension Result {
    
    typealias T = Value
    typealias E = Error

    func map<U>(@noescape f: T -> U) -> Result<U, E> {
        switch self {
        case let .Success(value):
            return Result<U,E>.Success(f(value))
        case let .Failure(error):
            return Result<U,E>.Failure(error)
        }
    }
    
    func flatMap<U>(@noescape f: T -> Result<U, E>) -> Result<U, E> {
        return Result.flatten(map(f))
    }
}

private extension Result {
    
    static func flatten<T>(result: Result<Result<T, E>, E>) -> Result<T, E> {
        switch result {
        case let .Success(value):
            return value
        case let .Failure(error):
            return .Failure(error)
        }
    }
}


//extension Result {
//
//    // 如果是 .Success 就直接返回值，如果是 .Failure 抛出错误
//    func resolve() throws -> T {
//        switch self {
//        case let .Success(value): return value
//        case let .Failure(error): throw error
//        }
//    }
//    
//    // 如果表达式返回值则构建一个 .Success，否则就构建一个 .Failure
//    init(@noescape _ throwingExpression: Void throws -> T) {
//        do {
//            let value = try throwingExpression()
//            self = .Success(value)
//        } catch let error {
//            
//            guard let error = error as? E else {
//                fatalError("APIResult throws a non \(E.self) type")
//            }
//            self = .Failure(error)
//        }
//    }
//}





