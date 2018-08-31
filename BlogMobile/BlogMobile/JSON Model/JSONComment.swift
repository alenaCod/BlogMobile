//
//  JSONComment.swift
//  BlogMobile
//
//  Created by Mac on 8/31/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import Foundation

struct JSONComment: Codable {
    let id: Int
    let text: String
    let datePublic: String
    let author: String
}
