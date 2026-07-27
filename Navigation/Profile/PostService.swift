//
//  PostService.swift
//  Navigation
//
//  Created by Mysty Mystylal on 27.07.2026.
//

import Foundation
import StorageService
  
class PostService {
    let posts: [Post] = [Post(author: "Intel", description: "Intel показал НОВЫЕ процессоры Core Ultra 7 270K Plus и 250K Plus — «самые быстрые игровые процессоры в мире».", image: "intel", likes: 245, views: 1200),
    Post(author: "Песков", description: "«Думайте о MAX, а не о Telegram», — посоветовал Песков.", image: "peskov", likes: 566, views: 3400),
    Post(author: "Ferrari", description: "Ferrari показала открытую версию своей самой доступной модели — Amalfi Spider.", image: "ferrari", likes: 890, views: 5600),
    Post(author: "Resident Evil", description: "Resident Evil Requiem получит сюжетное DLC — официально.", image: "resident", likes: 312, views: 2100)
    ]
    
  }
