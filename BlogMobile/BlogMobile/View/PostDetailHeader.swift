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
    @IBOutlet weak var nameMark: UILabel!
    
    func configureView(post :JSONPost)  {
        self.textPost.text = post.text
        self.datePost.text = post.datePublic
    }
    
    func configureViewMark(marks:[JSONMark])  {
        print("===> marks: ", marks)
        //пройтись по каждому элементу и вывести все имена
        self.nameMark.text = marks[0].name
       // self.datePost.text = post.datePublic
    }
}
