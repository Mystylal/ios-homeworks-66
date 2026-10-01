
//
//  CoreDataService.swift
//  Navigation
//
//  Created by Mysty Mystylal on 30.09.2026.
//

import Foundation
import CoreData
import StorageService

class CoreDataService {
    static let shared = CoreDataService()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LikedPosts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext () {
        if context.hasChanges {
            try? context.save()
        }
    }
    
    func savePost(_ post: Post) {
        let cdPost = CDPost(context: context)
        cdPost.author = post.author
        cdPost.postDescription = post.description
        cdPost.image = post.image
        cdPost.likes = Int32(post.likes)
        cdPost.views = Int32(post.views)
        saveContext()
    }
    
    func fetchPosts() -> [CDPost] {
        let request = CDPost.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
}
