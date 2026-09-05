//
//  NetworkService.swift
//  Navigation
//
//  Created by Mysty Mystylal on 05.09.2026.
//

import Foundation

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        let urlString: String
        
        switch configuration {
        case .people(let string):
            urlString = string
        case .starships(let string):
            urlString = string
        case .planets(let string):
            urlString = string
        }
    
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let httpResponse = response as? HTTPURLResponse{
                print(httpResponse.allHeaderFields)
                print(httpResponse.statusCode)
                return
            }
            guard let data = data, let string = String(data: data, encoding: .utf8) else { return }
            print(string)
            
        }
        task.resume()
    }
}
