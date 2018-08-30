//
//  PostCell.swift
//  BlogMobile
//
//  Created by Mac on 8/30/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import UIKit
import Foundation

class PostCell: UITableViewCell {

    @IBOutlet weak var titlePost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
  func configureCell(forPost post: JSONPost){
    titlePost.text = post.title
    
    }
    
    
}
