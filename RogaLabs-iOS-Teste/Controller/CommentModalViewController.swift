//
//  CommentModalViewController.swift
//  RogaLabs-iOS-Teste
//
//  Created by Luiz Fernando Andrade on 26/04/22.
//

import UIKit

class CommentModalViewController: UIViewController {

    @IBOutlet weak var commentsTableView: UITableView!
    
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        commentsTableView.register(UINib(nibName: K.postCellNibName, bundle: nil), forCellReuseIdentifier: K.commentCellIdentifier)
    }
    
//    @IBAction func dismissModal(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let postsVC = segue.destination as? PostsViewController {
//            posts = postsVC.posts
//        }
//    }
}

extension CommentModalViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.commentCellIdentifier, for: indexPath) as! CommentCell
        if comments.isEmpty{
            print("No comments received")
            return cell
        } else {
            cell.nameLabel.text = comments[indexPath.row].name
            cell.emailLabel.text = comments[indexPath.row].email
            cell.bodyLabel.text = comments[indexPath.row].body
            return cell
        }
    }
}
