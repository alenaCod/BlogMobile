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
        let url = "http://fed-blog.herokuapp.com/api/v1/posts?page=0&size=20"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
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
//                print("====",response.request)
//                print("---",response.response)
//                print("#####",response.data)
//                print("/////",response.result)
//
//                if let json = response.result.value {
//                    print("succes",json)
//                    let post: [JSONPost] = try
//                    decoder.decode([JSONPost].self, from: result)
//                    print("post: ", post)
//                    completion(post)
//                } else {
//                    print("error")
//                }
//
//                    let res = ParserResponseUtils.parseSearchResponse(json).prefix(Constants.recipeLimit)
                   // comletion(Array(res))
//                } else {
//                    comletion(response)//[])
//                }
//        }
//    }
//
//}
