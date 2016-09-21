//
//  Serializable.swift
//  Pods
//
//  Created by 王小涛 on 16/9/19.
//
//

public protocol ResponseObjectSerializable {
    static func object(from response: NSHTTPURLResponse, withRepresentation representation: AnyObject) -> Self?
}

public protocol ResponseCollectionSerializable {
    static func collection(from response: NSHTTPURLResponse, withRepresentation representation: AnyObject) -> [Self]?
}

public extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    
    static func collection(from response: NSHTTPURLResponse, withRepresentation representation: AnyObject) -> [Self]? {
    
        guard let representation = representation as? [AnyObject] else {
            return nil
        }
        
        typealias T = Self
        
        return representation.flatMap { item -> T? in
            return T.object(from: response, withRepresentation: item)
        }
    }
}


