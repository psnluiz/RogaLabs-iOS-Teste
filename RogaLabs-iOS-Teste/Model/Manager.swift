//
//  Manager.swift
//  RogaLabs-iOS-Teste
//
//  Created by Luiz Fernando Andrade on 25/04/22.
//

import Foundation

protocol ManagerDelegate {
    func didUpdatePosts(_ manager: Manager, posts: [Post])
    func didFailWithError(error: Error)
}

//had to add prop comments and add mutating to funcs in order

class Manager {
    
    var delegate: ManagerDelegate?
    var comments: [Comment] = []
    
    func fetchPosts(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { [self] data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let posts = parsePostJSON(postsData: safeData) {
                        delegate?.didUpdatePosts(self, posts: posts)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
    func parsePostJSON(postsData: Data) -> [Post]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Post].self, from: postsData)
            var posts: [Post] = []
            for n in 0..<decodedData.count {
                
                let userId = decodedData[n].userId
                let id = decodedData[n].id
                let title = decodedData[n].title
                let body = decodedData[n].body
                
                self.fetchComments(for: id)
                
                let post = Post(userId: userId, id: id, title: title, body: body, comments: self.comments)
                posts.append(post)
            }
            return posts
        } catch {
            delegate?.didFailWithError(error: error)
        }
        return []
    }
    
    func fetchComments(for postId: Int) {
        let urlString = K.postsApiURL + "/\(postId)/comments"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                
                if let safeData = data {
                    if let comments = self.parseCommentsJSON(commentsData: safeData) {
                        self.comments = comments
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseCommentsJSON(commentsData: Data) -> [Comment]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Comment].self, from: commentsData)
            var comments: [Comment] = []
            for n in 0..<decodedData.count {
                let postId = decodedData[n].postId
                let id = decodedData[n].id
                let name = decodedData[n].name
                let email = decodedData[n].email
                let body = decodedData[n].body
                
                let comment = Comment(postId: postId, id: id, name: name, email: email, body: body)
                comments.append(comment)
            }
            return comments
        } catch {
            delegate?.didFailWithError(error: error)
        }
        return nil
    }
    
}
