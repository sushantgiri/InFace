//
//  PostsView.swift
//  InFace
//
//  Created by Sushant Giri on 26/08/2024.
//

import SwiftUI

struct PostsView: View {
    @ObservedObject var viewModel = PostViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                if viewModel.posts.isEmpty{
                    Text("No posts found").font(.headline)
                }else{
                    List(viewModel.posts){ post in
                        PostRow(post: post)
                    }
                }
            }
            .navigationTitle("Feed")
            .onAppear{
                viewModel.loadPostsFromLocalStorage()
                viewModel.fetchPosts()
            }
        }
    }
}

struct PostRow: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: post.creator.avatar)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } placeholder: {
                    Circle().fill(Color.gray).frame(width: 40, height: 40)
                }
                
                VStack(alignment: .leading) {
                    Text("\(post.creator.firstName) \(post.creator.lastName)")
                        .font(.headline)
                    Text(post.createdAt)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Text(post.postText)
                .font(.body)
                .padding(.vertical, 8)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(post.images, id: \.self) { imageUrl in
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .cornerRadius(8)
                        } placeholder: {
                            Rectangle().fill(Color.gray).frame(width: 200, height: 200)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    PostsView()
}
