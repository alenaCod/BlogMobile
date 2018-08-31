//
//  CommentCell.swift
//  BlogMobile
//
//  Created by Mac on 8/31/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import UIKit
import Foundation

class CommentCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(comment:JSONComment){
        authorLabel.text = comment.author
        dateLabel.text = comment.datePublic
        textlabel.text = comment.text
        
    }

    
}
