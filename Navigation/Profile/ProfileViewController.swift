//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 10.03.2026.
//

import UIKit

class ProfileViewController: UIViewController {
    private let headerView = ProfileHeaderView()
    
    private lazy var actionButton: UIButton = {
         let button = UIButton()
         button.setTitle("Перейти", for: .normal)
         button.backgroundColor = .systemBlue
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .lightGray
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionButton)
        headerView.setupViews()
        
        let safeAreaGuide = view.safeAreaLayoutGuide
                         
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo:safeAreaGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo:safeAreaGuide.bottomAnchor)
                 ])
             }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        headerView.frame = view.frame
    }

}
