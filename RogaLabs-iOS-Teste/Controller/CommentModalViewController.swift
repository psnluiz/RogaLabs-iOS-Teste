//
//  CommentModalViewController.swift
//  RogaLabs-iOS-Teste
//
//  Created by Luiz Fernando Andrade on 26/04/22.
//

import UIKit

class CommentModalViewController: UIViewController {

    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    var comments: [Comment] = []
    var post: Post?
    
    var manager = Manager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let postId = post?.id else {return}
        
        commentsTableView.dataSource = self
        manager.delegate = self
        manager.fetchComments(for: postId)
    
        commentsTableView.register(UINib(nibName: K.commentCellNibName, bundle: nil), forCellReuseIdentifier: K.commentCellIdentifier)
    }
    
    @IBAction func dismissModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //    @IBAction func dismissModal(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
    
}

extension CommentModalViewController: ManagerDelegate {
    func didUpdatePosts(_ manager: Manager, posts: [Post]) {
        return
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateComments(_ manager: Manager, comments: [Comment]) {
        self.comments = comments
        DispatchQueue.main.async {
            self.commentsTableView.reloadData()
        }
    }
}

extension CommentModalViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.commentCellIdentifier, for: indexPath) as! CommentCell
        
        cell.nameLabel.text = "Name: \(comments[indexPath.row].name)"
        cell.emailLabel.text = "Email: \(comments[indexPath.row].email)"
        cell.bodyLabel.text = comments[indexPath.row].body
        return cell
    }
}
