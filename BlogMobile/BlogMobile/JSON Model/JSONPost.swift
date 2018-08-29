//
//  JSON Response.swift
//  BlogMobile
//
//  Created by Mac on 8/28/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import Foundation

struct JSONPost: Codable {
    let id: Int
    let title: String
    let text: String
    let datePublic: String
}
