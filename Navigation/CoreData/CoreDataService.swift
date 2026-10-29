
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
        container.viewContext.automaticallyMergesChangesFromParent = true
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
        persistentContainer.performBackgroundTask { backgroundContext in
            let cdPost = CDPost(context: backgroundContext)
            cdPost.author = post.author
            cdPost.postDescription = post.description
            cdPost.image = post.image
            cdPost.likes = Int32(post.likes)
            cdPost.views = Int32(post.views)
            
            if backgroundContext.hasChanges {
                try? backgroundContext.save()
            }
        }
    }
    
    func deletePost(_ post: CDPost) {
        let objectID = post.objectID
        persistentContainer.performBackgroundTask { backgroundContext in
            if let object = try? backgroundContext.existingObject(with: objectID){
                backgroundContext.delete(object)
                if backgroundContext.hasChanges {
                    try? backgroundContext.save()
                }
            }
        }
    }
    
    func fetchPosts() -> [CDPost] {
        let request = CDPost.fetchRequest()
        request.fetchBatchSize = 20
        return (try? context.fetch(request)) ?? []
    }
    
    func fetchPosts(author: String) -> [CDPost] {
        let request = CDPost.fetchRequest()
        request.predicate = NSPredicate(format: "author == %@", author)
        request.fetchBatchSize = 20
        return (try? context.fetch(request)) ?? []
    }
}
