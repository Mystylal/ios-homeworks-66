//
//  User.swift
//  Navigation
//
//  Created by Mysty Mystylal on 19.07.2026.
//

import UIKit

class User{
    let login: String
    let fullName: String
    let avatar: UIImage
    let status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

protocol UserService{
    func getUser(login:String) -> User?
}

class CurrentUserService: UserService{
    private let user:User
    
    init(user: User) {
        self.user = user
    }
    
    func getUser(login: String) -> User? {
        login == user.login ? user : nil
    }
}

class TestUserService: UserService {
    private let user = User(login: "peskovv",
                            fullName: "Peskov",
                            avatar: UIImage(named: "peskov") ?? UIImage(),
                            status: "Testing...")

    func getUser(login: String) -> User? {
        user
    }
}
