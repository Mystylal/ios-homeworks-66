//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Mysty Mystylal on 16.11.2026.
//

import Foundation

enum LoginState: Equatable {
    case initial
    case loading
    case success
    case failure(message: String)
}

class LoginViewModel{
    private let loginDelegate: LoginViewControllerDelegate?
    var onStateChange: ((LoginState) -> Void)?
    
    var state: LoginState = .initial {
        didSet {onStateChange?(state) }
    }
    
    init (loginDelegate: LoginViewControllerDelegate?) {
        self.loginDelegate = loginDelegate
    }
    
    func logIn(email: String, password: String){
        guard !email.isEmpty else {
            state = .failure(message: NSLocalizedString("login.enter_username", comment: ""))
            return
        }
        guard !password.isEmpty else {
            state = .failure(message: NSLocalizedString("login.enter_password", comment: ""))
            return
        }
        guard password.count >= 6 else {
            state = .failure(message: String(format: NSLocalizedString("login.password_too_short", comment: ""), 6))
            return
        }
        
        state = .loading
        loginDelegate?.checkCredentials(email: email, password: password) { [weak self] result in
           
            switch result {
                case .success:
                    self?.state = .success
                case .failure(let message):
                    self?.loginDelegate?.signUp(email: email, password: password) { signUpResult in
                        switch signUpResult{
                            case .success:
                                self?.state = .success
                            case .failure(let erorr):
                                self?.state = .failure(message: erorr.localizedDescription)
                        }
                }
            }
        }
    }
}
