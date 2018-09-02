//
//  APIService.swift
//  BlogMobile
//
//  Created by Mac on 8/28/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    static let sharedInstance = APIService()
    
    func getPosts(page: Int, size: Int, comletion: @escaping (_ result: [JSONPost]) -> Void) {
        let endpoint = Endpoint.getPosts(page: page, size: size)
        Alamofire.request(endpoint.url, method: endpoint.method, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                let decoder = JSONDecoder()
                do {
                    guard let data = response.data else {
                        comletion([])
                        return
                    }
                    let posts: [JSONPost] = try decoder.decode([JSONPost].self, from: data)
                    print("posts: ", posts)
                    comletion(posts)
                } catch {
                    comletion([])
                }
        }
    }
    
    func getMarks(idPost: Int, comletion: @escaping (_ result: [JSONMark]) -> Void) {
        let endpoint = Endpoint.getPostMarks(postId: idPost)
        Alamofire.request(endpoint.url, method: endpoint.method, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                let decoder = JSONDecoder()
                do {
                    guard let data = response.data else {
                        comletion([])
                        return
                    }
                    let marks: [JSONMark] = try decoder.decode([JSONMark].self, from: data)
                    print("marks: ", marks)
                    comletion(marks)
                } catch {
                    comletion([])
                }
        }
        
    }
    
    func getComments(postId: Int, comletion: @escaping (_ result: [JSONComment]) -> Void) {
        let endpoint = Endpoint.getPostComments(postId: postId)
        Alamofire.request(endpoint.url, method: endpoint.method, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                let decoder = JSONDecoder()
                do {
                    guard let data = response.data else {
                        comletion([])
                        return
                    }
                    let comments: [JSONComment] = try decoder.decode([JSONComment].self, from: data)
                    print("comments: ", comments)
                    comletion(comments)
                } catch {
                    comletion([])
                }
        }
        
    }
}

