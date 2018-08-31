//
//  PostDetailHeader.swift
//  BlogMobile
//
//  Created by Mac on 8/31/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import UIKit

class PostDetailHeader: UIView {
    
    @IBOutlet weak var textPost: UILabel!
    @IBOutlet weak var datePost: UILabel!
    
    func configureView(post :JSONPost)  {
        self.textPost.text = post.text
        self.datePost.text = post.datePublic
    }
}
