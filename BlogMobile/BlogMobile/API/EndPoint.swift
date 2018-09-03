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
    case getPosts(page: Int, size: Int)
    case getPostMarks(postId: Int)
    case getPostComments(postId: Int, page: Int, size: Int)

    var method: HTTPMethod {
        
        switch self {

        case .getPosts,
             .getPostMarks,
             .getPostComments:
            return .get
        }
    }
    
    var url: String {
        let baseUrl = "http://fed-blog.herokuapp.com"
        
        switch self {
        case .getPosts(let page,let size):
            return baseUrl + "/api/v1/posts?page=\(page.toString())&size=\(size.toString())"
        case .getPostMarks(let postId):
            return baseUrl + "/api/v1/posts/\(postId.toString())/marks"
        case .getPostComments(let postId, let page, let size):
            return baseUrl + "/api/v1/comments/posts/\(postId.toString())?page=\(page.toString())&size=\(size.toString())"
        }
    }        
}

