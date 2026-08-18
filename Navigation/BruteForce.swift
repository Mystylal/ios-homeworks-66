//
//  BruteForce.swift
//  Navigation
//
//  Created by Mysty Mystylal on 15.08.2026.
//

import Foundation

class BruteForce{
    private var allowedCharacters: [String]
    
    init() {
        let digits = "0123456789"
        let lowercase = "abcdefghijklmnopqrstuvwxyz"
        let uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        allowedCharacters = Array(digits + lowercase + uppercase).map{String($0)}
    }
    
    func gereatePassword(length: Int) -> String {
        return (0..<length).compactMap { _ in allowedCharacters.randomElement()}.joined()
    }
    
    func generateBruteForce(_ string: String) -> String {
        var str: String = string
        if str.isEmpty {
            str.append(allowedCharacters[0])
        }
        else {
            let lastChar = String(str.removeLast())
            let lastIndex = allowedCharacters.firstIndex(of: lastChar)!
            let nextIndex = (lastIndex + 1) % allowedCharacters.count
            str.append(allowedCharacters[nextIndex])
            
            if nextIndex == 0 {
                let nextStr = generateBruteForce(String(str.dropLast()))
                str = nextStr + allowedCharacters[0]
            }
        }
        return str
    }
    
    func bruteForce(password: String, completion: @escaping (String) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in guard let self else { return }
            var passwordToCheck: String = ""
            while passwordToCheck != password {
                passwordToCheck = self.generateBruteForce(passwordToCheck)
            }
            DispatchQueue.main.async {
                    completion(passwordToCheck)
            }
        }
    }
}
