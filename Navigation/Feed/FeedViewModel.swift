//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Mysty Mystylal on 16.11.2026.
//

import Foundation

protocol FeedModelProtocol {
    func check(word: String, end: @escaping (Bool) -> Void)
}

extension FeedModel: FeedModelProtocol {}

enum FeedState: Equatable {
    case initial
    case checking
    case checked(result:Bool)
    case error
}

class FeedViewModel{
    private var feedModel: FeedModelProtocol
    var onStateChange: ((FeedState) -> Void)?
    
    var state: FeedState = .initial {
        didSet{ onStateChange?(state) }
    }
    
    init(feedModel: FeedModelProtocol = FeedModel()) {
        self.feedModel = feedModel
    }
    
    func check(word: String) {
        guard !word.isEmpty else {
            state = .error
            return
        }
        state = .checking
        feedModel.check(word: word) { [weak self] result in
            self?.state = .checked(result: result)
        }
    }
}
    
