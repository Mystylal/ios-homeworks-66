//
//  ChuckNorrisService.swift
//  Navigation
//
//  Created by Mysty Mystylal on 29.09.2026.
//

import Foundation
import RealmSwift

struct QuoteResponse:Decodable {
    let id:String
    let value:String
    let categories: [String]
}

class ChuckNorrisService {
    func getRandomQuote(completion: @escaping (Result<QuoteResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                return
            }
            do {
                let quoteResponse = try JSONDecoder().decode(QuoteResponse.self, from: data)
                completion(.success(quoteResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

class QuoteRepository{
    func save(_ response:QuoteResponse){
        guard let realm = try? Realm() else {
            return
        }
        guard realm.object(ofType: RealmQuote.self, forPrimaryKey: response.id) == nil else {
            return
        }
    
        
        let quote = RealmQuote()
        quote.id = response.id
        quote.value = response.value
        quote.category = response.categories.first
        quote.savedAt = Date()
        
        try? realm.write {
            realm.add(quote)
            if let categoryName = response.categories.first, realm.object(ofType: RealmCategory.self, forPrimaryKey: categoryName) == nil {
                let category = RealmCategory()
                category.name = categoryName
                realm.add(category)
            }
        }
    }
}
