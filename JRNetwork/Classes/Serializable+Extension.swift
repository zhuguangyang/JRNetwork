//
//  Serializable+Extension.swift
//  Pods
//
//  Created by 王小涛 on 16/9/19.
//
//

import Foundation


extension Int: ResponseObjectSerializable {
    
    public init?(json: Any) {
        
        if let value = json as? NSNumber {
            self = value.integerValue
        }else if let object = json as? String, let value = Int(object) {
            self = value
        }else {
            return nil
        }
    }
}


extension Double: ResponseObjectSerializable {
    
    public init?(json: Any) {
        
        if let value = json as? NSNumber {
            self = value.doubleValue
        }else if let object = json as? String, let value = Double(object) {
            self = value
        }else {
            return nil
        }
    }
}


extension String: ResponseObjectSerializable {
    
    public init?(json: Any) {
        
        if let object = json as? String {
            self = object
        }else {
            return nil
        }
    }
}



