//
//  MarkView.swift
//  BlogMobile
//
//  Created by Mac on 9/3/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import Foundation
import UIKit

class MarkView: UIView {
    
    @IBOutlet weak var lblTitle: UILabel!

    private let tokenViewHeight: CGFloat = 25.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
    }
    
    func populate(text: String) {
        lblTitle.text = text
        
        let size = lblTitle.sizeThatFits(CGSize(width: 1000, height: tokenViewHeight))
        self.frame = CGRect(x: 0, y: 0, width: size.width + 35, height: tokenViewHeight)
    }
}
