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
    
    func getPosts(comletion: @escaping (_ result: [JSONPost]?) -> Void) {
        let endpoint = Endpoint.postRequest
        Alamofire.request(endpoint.url, method: endpoint.method, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                let decoder = JSONDecoder()
                do {
                    guard let data = response.data else {
                        comletion(nil)
                        return
                    }
                    let posts: [JSONPost] = try decoder.decode([JSONPost].self, from: data)
                    print("posts: ", posts)
                    comletion(posts)
                } catch {
                    comletion(nil)
                }
        }
    }
}

