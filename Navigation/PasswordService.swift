//
//  PasswordService.swift
//  Navigation
//
//  Created by Mysty Mystylal on 27.09.2026.
//

import Foundation
import KeychainAccess

class PasswordService {
    private let keychain = Keychain(service: "com.mystylal.Navigation.password")
    private let passwordKey = "password"
    
    var hasPassword: Bool {
        (try? keychain.getString(passwordKey)) != nil
    }
    
    func save(password: String) {
        try? keychain.set(password, key: passwordKey)
    }
    
    func check(password: String) -> Bool {
        (try? keychain.getString(passwordKey)) == password
    }
    
}
