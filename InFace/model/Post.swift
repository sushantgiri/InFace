//
//  Post.swift
//  InFace
//
//  Created by Sushant Giri on 26/08/2024.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: String
    let createdAt: String
    let postText: String
    let images: [String]
    let creator: Creator
    let body: String? // Optional, since it's missing in the provided JSON
    
    struct Creator: Codable {
        let avatar: String
        let firstName: String
        let lastName: String
    }
}

