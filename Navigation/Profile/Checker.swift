//
//  Checker.swift
//  Navigation
//
//  Created by Mysty Mystylal on 20.07.2026.
//

//class Checker{
//    
//    static let shared = Checker()
//    private init(){}
//    
//    private let login = "cat"
//    private let password = "Dicson"
//    
//    func check(login: String, password: String) -> Bool{
//        login == self.login && password == self.password
//    }
//}

protocol LoginViewControllerDelegate: AnyObject{
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signUp(email: String, password: String,completion: @escaping (Result<Void, Error>) -> Void)}

protocol LoginFactory{
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory{
    func makeLoginInspector() -> LoginInspector {
        LoginInspector(checkerService: CheckerService())
    }
}
