//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Mysty Mystylal on 27.07.2026.
//

import Foundation
import StorageService

enum ProfileState{
    case initial
    case loading
    case loaded([Post])
    case error
}

protocol ProfileVMOutput: AnyObject {
    var state: ProfileState { get set }
    var currentState: ((ProfileState) -> Void)? { get set }
    func changeStateIfNeeded()
}

class ProfileViewModel: ProfileVMOutput {
    
    private let postService = PostService()
    var currentState: ((ProfileState) -> Void)?
    
    var state: ProfileState = .initial {
        didSet {
            currentState?(state)
        }
    }
    
    func changeStateIfNeeded() {
        state = .loading
        postService.fetchPosts{ [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let posts):
                state = .loaded(posts)
            case .failure:
                state = .error
            }
        }
    }
}
