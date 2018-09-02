//
//  MarkField.swift
//  BlogMobile
//
//  Created by Mac on 9/3/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import Foundation
import UIKit

struct TagField {
    
    var tokenMargin: Float
    var tokenHeight: Float
    
    private var line = 1
    private var tokensWidth = 0
    
    init (tokenMargin: Float, tokenHeight: Float) {
        self.tokenHeight = tokenHeight
        self.tokenMargin = tokenMargin
    }
    
    func getTokenViewScreenHeight() -> Float {
        let minHeight = Float(tokenHeight + 2)
        return minHeight * Float(line)
    }
    
    mutating func calculateTokensWidth(_ tokenField: UIView, _ tokenView: UIView) {
        let tokenWidth = Int(Float(tokenView.frame.width) + tokenMargin * 2)
        
        tokensWidth += tokenWidth
        if tokensWidth > Int(tokenField.frame.width) * line {
            tokensWidth = Int(tokenField.frame.width) * line + tokenWidth
            line += 1
        }
    }
}
