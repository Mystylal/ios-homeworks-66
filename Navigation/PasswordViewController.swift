//
//  PasswordViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 27.09.2026.
//

import UIKit

enum PasswordScreenMode {
    case create
    case verify
}
class PasswordViewController: UIViewController {
    private let mode: PasswordScreenMode
    private let passwordService = PasswordService()
    private var firstEnteredPassword: String?

    var onSuccess: (() -> Void)?
    
    init(mode:PasswordScreenMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var actionButton: CustomButton = {
        CustomButton(title: " ", titleColor: .white, backgroundColor: .systemBlue) {
            [weak self] in self?.actionButtonTup()}
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateButtonTitle()
        
        view.addSubview(passwordTextField)
        view.addSubview(actionButton)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 350),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func actionButtonTup() {
        let password = passwordTextField.text ?? ""
        switch mode {
        case .verify:
            guard passwordService.check(password: password) else {
                showAlert(message: "Неверный пароль")
                return
            }
            onSuccess?()
        case .create:
            guard password.count >= 4 else {
                showAlert(message: "Пароль должен быть не менее чем из 4 символов")
                return
            }
            if let first = firstEnteredPassword {
                if first == password {
                    passwordService.save(password: password)
                    onSuccess?()
                } else {
                    showAlert(message: "Пароли не совпадают")
                    firstEnteredPassword = nil
                    passwordTextField.text = ""
                    updateButtonTitle()
                }
            } else {
                firstEnteredPassword = password
                passwordTextField.text = ""
                updateButtonTitle()
            }
        }
    }
    
    private func updateButtonTitle() {
        switch mode {
        case .verify:
            actionButton.setTitle("Введите пароль", for: .normal)
        case .create:
            if firstEnteredPassword == nil {
                actionButton.setTitle("Создать пароль", for: .normal)
            } else {
                actionButton.setTitle("Повторите пароль", for: .normal)
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
