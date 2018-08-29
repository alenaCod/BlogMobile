//
//  ViewController.swift
//  BlogMobile
//
//  Created by Mac on 8/28/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    fileprivate var post: [JSONPost] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPostsFromServer()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadPostsFromServer() {
        APIService.sharedInstance.getPosts(comletion: {
            [weak self] result in
      
            if let _result = result as? [JSONPost] {
                self?.post = _result
            }
        })
    
    }

}

