//
//  RequestFactory.swift
//  MusicApp
//
//  Created by Madan on 08/11/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import Foundation
class RequestFactory {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
    static func listMusicRequest(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(GlobalConstants.kMusicKeyValue, forHTTPHeaderField: GlobalConstants.kMusicKey)
        request.setValue(GlobalConstants.kheaderValue, forHTTPHeaderField: GlobalConstants.kheaderAcceptKey)
        return request
    }

}
