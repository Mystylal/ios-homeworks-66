//
//  CheckerService.swift
//  Navigation
//
//  Created by Mysty Mystylal on 19.09.2026.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signUp(email: String, password: String,completion: @escaping (Result<Void, Error>) -> Void)
}

class CheckerService: CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
    func signUp(email: String, password: String,completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
}
