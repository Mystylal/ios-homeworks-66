//
//  LoginError.swift
//  Navigation
//
//  Created by Mysty Mystylal on 31.08.2026.
//

import Foundation

enum LoginError: Error {
    case emptyEmail
    case emptyPassword
    case passwordTooShort(minLength: Int)
}
