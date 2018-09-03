//
//  ViewController.swift
//  BlogMobile
//
//  Created by Mac on 8/28/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import UIKit
import Foundation

class PostViewController: UIViewController {
    
    static let nibName = "PostCell"
    static let cellIdentifier = "PostCellID"
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var post:[JSONPost] = [] {
        didSet{
            tableView.reloadData()
            isLoadingMore = false
            refreshControl.endRefreshing()
        }
    }
    var currentPage = 0
    var isLoadingMore = false
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PostViewController.refreshData), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        loadPostsFromServer()
        initTableView()
    }
    
    private func loadPostsFromServer(page: Int = 0, size: Int = 10) {
        APIService.sharedInstance.getPosts(page: page, size: size, comletion: {
            [weak self] result in
            
            if let _isLoadingMore = self?.isLoadingMore, _isLoadingMore {
                self?.post.append(contentsOf: result)
                self?.tableView.reloadData()
            } else {
                self?.post = result
            }
        })
    }
    
    private func initTableView() {
        let nib = UINib(nibName: PostViewController.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PostViewController.cellIdentifier)
        tableView.backgroundView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        
        tableView.estimatedRowHeight = 65.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: "LoadingCellID")
        
        // setup pull-to-refresh
        tableView.addSubview(refreshControl)
    }
    
    @objc func refreshData() {
        currentPage = 0
        loadPostsFromServer()
    }
    
    func goToDetailPost(forPost post: JSONPost){
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailPostViewController") as! DetailPostViewController
        detailVC.post = post
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func getListFromServer(_ page: Int){
        loadPostsFromServer(page: page)
    }
    
    fileprivate func loadMoreItemsForList(){
        currentPage += 1
        print("current page", currentPage)
        getListFromServer(currentPage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension PostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostViewController.cellIdentifier) as! PostCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.configureCell(forPost: post[indexPath.row])
            
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
            return post.count
        case 1:
            return isLoadingMore ? 1 : 0
        default:
            return 0
        }
    }
}

extension PostViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let p = post[indexPath.row]
            goToDetailPost(forPost: p)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        if (actualPosition.y > 0){
            print("DOWN")
        } else {
            print("UP")
            self.isLoadingMore = true
            self.tableView.reloadData()
            self.loadMoreItemsForList()
        }
    }
}




