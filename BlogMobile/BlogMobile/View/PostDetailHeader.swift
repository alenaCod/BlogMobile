//
//  PostDetailHeader.swift
//  BlogMobile
//
//  Created by Mac on 8/31/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import UIKit
import Foundation
import ZFTokenField

class PostDetailHeader: UIView {
    
    @IBOutlet weak var textPost: UILabel!
    @IBOutlet weak var datePost: UILabel!
    
    @IBOutlet weak var markField: ZFTokenField! {
        didSet {
            markField.delegate = self
            markField.dataSource = self
        }
    }
    
    @IBOutlet weak var markFieldViewHeightConstraint: NSLayoutConstraint!
    
    fileprivate let tokenMargin: CGFloat = 3.0
    fileprivate let tokenHeight: CGFloat = 25.0
    fileprivate var tagField = TagField(tokenMargin: Float(3), tokenHeight: Float(25))
    
    fileprivate var marksNames: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeTokenField()
    }
    
    private func initializeTokenField() {
        markField.textField?.isUserInteractionEnabled = false
        markField.textField?.placeholder = ""
    }
    
    func configureView(post :JSONPost)  {
        self.textPost.text = post.text + "" + "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley "
        self.datePost.text = post.datePublic
    }
    
    func configureViewMark(marks:[JSONMark])  {
        self.marksNames = marks.map({$0.name}); ["Lorem","Ipsum", "is simply", "dummy", "text", "of the printing", "and"]
        //
        markField.reloadData()
        
        if let height = tagField.getTokenViewScreenHeight() as? Float {
            markFieldViewHeightConstraint.constant = CGFloat(height)
        }
    }
}

// MARK: - ZFTokenFieldDelegate

extension PostDetailHeader: ZFTokenFieldDelegate {
    
    func tokenMarginInToken(in tokenField: ZFTokenField!) -> CGFloat {
        return tokenMargin
    }
}

// MARK: - ZFTokenFieldDataSource

extension PostDetailHeader: ZFTokenFieldDataSource {
    func lineHeightForToken(in tokenField: ZFTokenField!) -> CGFloat {
        return tokenHeight
    }
    
    func numberOfToken(in tokenField: ZFTokenField!) -> UInt {
        return UInt(marksNames.count)
    }
    
    func tokenField(_ tokenField: ZFTokenField!, viewForTokenAt index: UInt) -> UIView! {
        let tokenView = Bundle.main.loadNibNamed("MarkView", owner: nil, options: nil)!.first as! MarkView
        tokenView.populate(text: marksNames[Int(index)])
        tagField.calculateTokensWidth(tokenField, tokenView)
        
        return tokenView
    }
}

