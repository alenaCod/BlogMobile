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
    @IBOutlet weak var postView: PostDetailHeader!{
        didSet{
            postView.layer.cornerRadius = 10
        }
    }
       
    
    static let nibName = "CommentCell"
    static let cellIdentifier = "CommentCellID"
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var comments :[JSONComment] = [] {
        didSet{
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initHeader()
        title = "Details"
        loadMarksFromServer()
        loadCommentsFromServer()
        initTableView()
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
    
    private func loadCommentsFromServer() {
        guard let _post = post else {
            return
        }

        APIService.sharedInstance.getComments(postId: _post.id, comletion: {
            [weak self] result in
            
            if let _result = result as? [JSONComment] {
                self?.comments = _result
            } else {
                self?.comments = []
            }
        })

    }
    
    private func initTableView() {
        let nib = UINib(nibName: DetailPostViewController.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DetailPostViewController.cellIdentifier)
        tableView.backgroundView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: .zero)
        //tableView.separatorStyle = .none

        tableView.estimatedRowHeight = 91.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension DetailPostViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailPostViewController.cellIdentifier) as! CommentCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        cell.configureCell(comment: comments[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
}

extension DetailPostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}







