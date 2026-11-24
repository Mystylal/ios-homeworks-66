//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Mysty Mystylal on 24.11.2026.
//

import LocalAuthentication

class LocalAuthorizationService {
    
    func authenticateUser(_ completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            completion(false)
            return
        }
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Войти с помощью Face ID") { success, error in
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
}
    
