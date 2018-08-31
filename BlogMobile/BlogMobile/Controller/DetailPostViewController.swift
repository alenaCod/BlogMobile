//
//  DetailPostViewController.swift
//  BlogMobile
//
//  Created by Mac on 8/30/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import Foundation
import UIKit

class DetailPostViewController: UIViewController {
    
    var post: JSONPost?
    
    @IBOutlet weak var postView: PostDetailHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initHeader()
        title = "Details"
        loadMarksFromServer()
    }
    
    func initHeader() {
        if let _post = post  {
            postView.configureView(post: _post)
        } else {
            return
        }
    }
    
    private func loadMarksFromServer() {
        guard let _post = post else {
            return
        }
        
        APIService.sharedInstance.getMarks(idPost: _post.id, comletion: {
            [weak self] result in
            self?.postView.configureViewMark(marks: result)
        })
    }
}






