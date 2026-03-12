//
//  LogInViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 12.03.2026.
//

import UIKit

class LogInViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var logoImageView: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "Logo")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        return logoImage
    }()

    private lazy var emailTextField: UITextField = {
        let emailText = UITextField()
        emailText.placeholder = "Email or phone"
        emailText.textColor = .black
        emailText.font = UIFont.systemFont(ofSize: 16)
        emailText.tintColor = UIColor(named: "accentColor")
        emailText.autocapitalizationType = .none
        emailText.backgroundColor = .systemGray6
        emailText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        emailText.leftViewMode = .always
        emailText.translatesAutoresizingMaskIntoConstraints = false
        return emailText
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var passwordTextField: UITextField = {
        let passwordText = UITextField()
        passwordText.placeholder = "Password"
        passwordText.textColor = .black
        passwordText.font = UIFont.systemFont(ofSize: 16)
        passwordText.tintColor = UIColor(named: "accentColor")
        passwordText.isSecureTextEntry = true
        passwordText.backgroundColor = .systemGray6
        passwordText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        passwordText.leftViewMode = .always
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        return passwordText
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .systemGray6
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.clipsToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var logInButton: UIButton = {
        let logInButton = UIButton()
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.layer.cornerRadius = 10
        logInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        logInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .selected)
        logInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .highlighted)
        logInButton.clipsToBounds = true
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        return logInButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(separatorView)
        stackView.addArrangedSubview(passwordTextField)
        contentView.addSubview(logInButton)
        logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
         

            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),

            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant:16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -16),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }

    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
                             NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom = keyboardHeight ?? 0.0
       
    }

    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }

    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.willHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }


    
    @objc func logInButtonPressed() {
         let profile = ProfileViewController()
         navigationController?.pushViewController(profile, animated: true)
     }
}
