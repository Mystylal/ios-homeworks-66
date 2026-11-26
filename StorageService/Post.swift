//
//  Post.swift
//  StorageService
//
//  Created by Mysty Mystylal on 10.03.2026.
//

import Foundation
import UIKit


public struct Post {
    public let author: String
    public let description: String
    public let image: UIImage
    public let likes: Int
    public let views: Int
    
    public init(author: String, description: String, image: UIImage, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}


