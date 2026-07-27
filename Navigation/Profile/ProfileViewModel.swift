//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Mysty Mystylal on 27.07.2026.
//

import Foundation
import StorageService

class ProfileViewModel {
    private let postService = PostService()
    
    var posts: [Post]{
        postService.posts
    }
}
