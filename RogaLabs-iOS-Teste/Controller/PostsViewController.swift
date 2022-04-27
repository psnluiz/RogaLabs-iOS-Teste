//
//  PostsViewController.swift
//  RogaLabs-iOS-Teste
//
//  Created by Luiz Fernando Andrade on 25/04/22.
//

import UIKit

class PostsViewController: UIViewController {
    
    var posts: [Post] = []
    var manager = Manager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        manager.delegate = self
        
        tableView.register(UINib(nibName: K.postCellNibName, bundle: nil), forCellReuseIdentifier: K.postCellIdentifier)
        
        manager.fetchPosts(with: K.postsApiURL)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == K.commentsSegue else {return}
        
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if posts.isEmpty {
            return 0
        } else {
            return posts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.postCellIdentifier, for: indexPath) as! PostCell
        
        cell.titleLabel.text = self.posts[indexPath.row].title
        cell.bodyLabel.text = self.posts[indexPath.row].body
        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //could do this setup at prepare for segue method
        //let modalVC = CommentModalViewController()
        //modalVC.comments = posts[indexPath.row].comments!
        performSegue(withIdentifier: "PostToComments", sender: self)
    }
}

extension PostsViewController: ManagerDelegate {
    
    func didUpdatePosts(_ manager: Manager, posts: [Post]) {
        self.posts = posts
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


