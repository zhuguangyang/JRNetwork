//
//  URLRequestCachable.swift
//  Pods
//
//  Created by 王小涛 on 16/5/13.
//
//

import Alamofire

protocol URLRequestCachable: URLRequestConvertible {
    
    var cache: NSMutableURLRequest {
        get
    }
}

extension URLRequestCachable {
    
    var cache: NSMutableURLRequest {
        let request = URLRequest.mutableCopy() as! NSMutableURLRequest
        request.cachePolicy = .ReturnCacheDataDontLoad
        return request
    }
}


