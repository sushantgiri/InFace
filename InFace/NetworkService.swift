//
//  NetworkService.swift
//  InFace
//
//  Created by Sushant Giri on 26/08/2024.
//

import Foundation
import Combine

class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://6335259f849edb52d6fc398e.mockapi.io/web-n-app-tasks/posts"
    
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: baseURL) else{
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
