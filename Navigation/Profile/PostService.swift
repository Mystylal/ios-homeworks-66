//
//  PostService.swift
//  Navigation
//
//  Created by Mysty Mystylal on 27.07.2026.
//

import Foundation
import StorageService
import UIKit

enum PostStorage {
    static var posts: [Post] = [
        Post(author: "Intel", description: "Intel показал НОВЫЕ процессоры Core Ultra 7 270K Plus и 250K Plus — «самые быстрые игровые процессоры в мире».", image: UIImage(named: "intel") ?? UIImage(), likes: 245, views: 1200),
                                  
        Post(author: "Песков", description: "«Думайте о MAX, а не о Telegram», — посоветовал Песков.", image: UIImage(named: "peskov") ?? UIImage() , likes: 566, views:
       3400),
        
        Post(author: "Ferrari", description: "Ferrari показала открытую версию своей самой доступной модели — Amalfi Spider.", image: UIImage(named: "ferrari") ?? UIImage(), likes: 890, views: 5600),
        
        Post(author: "Resident Evil", description: "Resident Evil Requiem получит сюжетное DLC — официально.", image: UIImage(named: "resident") ?? UIImage(), likes:
       312, views: 2100) ]
}
class PostService {
    
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            completion(.success(PostStorage.posts))
        }
    }
}
