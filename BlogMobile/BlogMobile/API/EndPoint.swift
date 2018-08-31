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
    case getPosts
    case getPostMarks(postId: Int)

    var method: HTTPMethod {
        
        switch self {

        case .getPosts,
             .getPostMarks:
            return .get
        }
    }
    
    var url: String {
        let baseUrl = "http://fed-blog.herokuapp.com"
        
        switch self {
        case .getPosts:
            return baseUrl + "/api/v1/posts"
        case .getPostMarks(let postId):
            return baseUrl + "/api/v1/posts/\(postId.toString())/marks"
        }
    }        
}

