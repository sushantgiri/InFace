//
//  PostViewModel.swift
//  InFace
//
//  Created by Sushant Giri on 26/08/2024.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    
    @Published var posts:[Post] = []
    private var cancellables = Set<AnyCancellable>()
    private let networkService = NetworkService.shared
    
    init(){
        fetchPosts()
    }
    
    func fetchPosts(){
        networkService.fetchPosts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching posts: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, 
//                receiveValue: { [weak self] postsData in
//                          if let data = postsData as? Data {
//                              if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                                  print(json)
//                              }
//                          }
//                      })
                  
                  receiveValue: { [weak self] posts in
                self?.posts = posts
                self?.savePostsToLocalStorage(posts: posts)
            })
            .store(in: &cancellables)

    }
    
    func savePostsToLocalStorage(posts: [Post]){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(posts){
            UserDefaults.standard.set(encoded, forKey: "savedPosts")
        }
    }
    
    func loadPostsFromLocalStorage(){
        if let savedPosts = UserDefaults.standard.data(forKey: "savedPosts"){
            let decoder = JSONDecoder()
            if let loadedPosts = try? decoder.decode([Post].self, from: savedPosts){
                self.posts = loadedPosts
            }
        }
    }
}
