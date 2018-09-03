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
    static let nibName = "CommentCell"
    static let cellIdentifier = "CommentCellID"
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var comments :[JSONComment] = [] {
        didSet{
            tableView?.reloadData()
            isLoadingMore = false
        }
    }
    
    var currentPage = 0
    var isLoadingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initHeader()
        title = "Details"
        loadMarksFromServer()
        loadCommentsFromServer()
        initTableView()
    }
    
    private func initHeader() {
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
    
    private func loadCommentsFromServer(page: Int = 0, size: Int = 10) {
        guard let _post = post else {
            return
        }
        
        APIService.sharedInstance.getComments(postId: _post.id, page: page, size: size, comletion: {
            [weak self] result in
            
            if let _isLoadingMore = self?.isLoadingMore, _isLoadingMore {
                self?.comments.append(contentsOf: result)
                self?.tableView.reloadData()
            } else {
                self?.comments = result
            }
        })
    }
    
    private func initTableView() {
        let nib = UINib(nibName: DetailPostViewController.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DetailPostViewController.cellIdentifier)
        tableView.backgroundView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        
        tableView.estimatedRowHeight = 91.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: "LoadingCellID")
    }
    
    private func getListFromServer(_ page: Int){
        loadCommentsFromServer(page: page)
    }
    
    fileprivate func loadMoreItemsForList(){
        currentPage += 1
        print("current page", currentPage)
        getListFromServer(currentPage)
    }
}

extension DetailPostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPostViewController.cellIdentifier) as! CommentCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.configureCell(comment: comments[indexPath.row])
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCellID", for: indexPath) as! LoadingCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.spinner.startAnimating()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return comments.count
        case 1:
            return isLoadingMore ? 1 : 0
        default:
            return 0
        }
    }
}

extension DetailPostViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        if (actualPosition.y < 0){
            print("UP")
            self.isLoadingMore = true
            self.tableView.reloadData()
            self.loadMoreItemsForList()
        }
    }
}








