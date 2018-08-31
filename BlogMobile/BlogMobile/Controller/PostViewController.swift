//
//  ViewController.swift
//  BlogMobile
//
//  Created by Mac on 8/28/18.
//  Copyright © 2018 Alona Moiseyenko. All rights reserved.
//

import UIKit


class PostViewController: UIViewController {
    
    static let nibName = "PostCell"
    static let cellIdentifier = "PostCellID"

    @IBOutlet weak var tableView: UITableView!

     fileprivate var post:[JSONPost] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPostsFromServer()
        initTableView()
    }

    private func loadPostsFromServer() {
        APIService.sharedInstance.getPosts(comletion: {
            [weak self] result in
            
            if let _result = result as? [JSONPost] {
                self?.post = _result
            } else {
                self?.post = []
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
    }
    
    func goToDetailPost(forPost post: JSONPost){
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailPostViewController") as! DetailPostViewController
            detailVC.post = post
        navigationController?.pushViewController(detailVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostViewController.cellIdentifier) as! PostCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.configureCell(forPost: post[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
}

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let p = post[indexPath.row]
        goToDetailPost(forPost: p)
    }
}


