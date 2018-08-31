//
//  EndPoint.swift
//  BlogMobile
//
//  Created by Mac on 8/29/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import Foundation
import Alamofire

//class EndPoint {
//
//static let sharedInstance = EndPoint()

enum Endpoint {
    case postRequest

    var method: HTTPMethod {
        switch self {
        case .postRequest:
            return .get
        }
    }
    
    var url: String {
        let baseUrl = "http://fed-blog.herokuapp.com"
        
        switch self {
        case .postRequest:
            return baseUrl + "/api/v1/posts"
        }
    }        
}

