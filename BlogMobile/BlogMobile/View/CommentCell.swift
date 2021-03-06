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

    @IBOutlet weak var commentView: UIView!{
        didSet{
            commentView.layer.cornerRadius = 10
            commentView.layer.borderColor = UIColor.orange.cgColor
            commentView.layer.borderWidth = 2
            
        }
    }
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
  
    @IBOutlet weak var textlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(comment:JSONComment){
        authorLabel.text = comment.author
        dateLabel.text = comment.datePublic
        textlabel.text = comment.text
    }
}
