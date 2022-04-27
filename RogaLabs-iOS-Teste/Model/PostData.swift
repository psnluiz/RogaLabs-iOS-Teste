//
//  Post.swift
//  RogaLabs-iOS-Teste
//
//  Created by Luiz Fernando Andrade on 25/04/22.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


struct Comment: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

