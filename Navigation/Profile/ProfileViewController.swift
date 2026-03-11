//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 10.03.2026.
//

import UIKit

class ProfileViewController: UIViewController {
    private let headerView = ProfileHeaderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .lightGray
        view.addSubview(headerView)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        headerView.frame = view.frame
    }

}
