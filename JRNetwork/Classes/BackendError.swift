//
//  BackendError.swift
//  Pods
//
//  Created by 王小涛 on 16/9/19.
//
//

import Foundation

public enum BackendError: ErrorType {
    case Network(error: NSError)
    case DataSerialization(reason: String)
    case JSONSerialization(error: NSError)
    case ObjectSerialization(reason: String, object: AnyObject)
    case XMLSerialization(error: NSError)
}


