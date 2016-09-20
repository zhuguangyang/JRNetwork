//
//  Network.swift
//  Pods
//
//  Created by 王小涛 on 16/9/19.
//
//

import Foundation
import Alamofire

public protocol NSURLRequestConvertible {
    var reqeust: NSURLRequest {get}
}

public protocol Network {
    
    init(url: NSURLRequestConvertible)
    
    func responseObject<T: ResponseObjectSerializable>(completed: Result<T, BackendError> -> Void)
    func responseCollection<T: ResponseCollectionSerializable>(completed: Result<T, BackendError> -> Void)
}

public enum BackendError: ErrorType {
    case Network(error: NSError)
    case DataSerialization(reason: String)
    case JSONSerialization(error: NSError)
    case ObjectSerialization(reason: String, object: AnyObject)
    case XMLSerialization(error: NSError)
}


