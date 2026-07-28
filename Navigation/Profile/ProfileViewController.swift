//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 10.03.2026.
//

import UIKit
import StorageService

private var profileHeaderView: ProfileHeaderView?

class ProfileViewController: UIViewController {
    private let user: User
    private let viewModel: ProfileVMOutput
    
    init(user: User, viewModel: ProfileVMOutput){
        self.user = user
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private var posts: [Post] = []
    private let photos: [String] = (1...20).map { "photo\($0)" }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        #if DEBUG
        view.backgroundColor = .white
        #else
        view.backgroundColor = .blue
        #endif
        view.addSubview(tableView)
        setupConstraints()
        tuneTableView()
        bindViewModel()
        viewModel.changeStateIfNeeded()
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo:safeAreaGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo:view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo:safeAreaGuide.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.register(PostTableViewCell.self,forCellReuseIdentifier: "PostCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
    }
    
    private func bindViewModel() {
        viewModel.currentState = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break
            case .loading:
                print("Loading")
            case .loaded(let posts):
                self.posts = posts
                self.tableView.reloadData()
            case .error:
                print("Error")
            }
        }
    }
    
    private func showAvatarAnimation() {
         
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {guard let cell = tableView.dequeueReusableCell(withIdentifier:"PhotosCell", for: indexPath) as? PhotosTableViewCell else {
            fatalError("could not dequeueReusableCell")
            }
            cell.update(Array(photos.prefix(4)))
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        cell.update(posts[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
          2
    }
}
                                                               
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = ProfileHeaderView()
        headerView.setupViews()
        headerView.update(with: user)
        headerView.onAvatarTap = {[weak self] in self?.showAvatarAnimation()}
        
        return headerView
    }
                                                                     
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         section == 0 ? 220 : 0
     }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if indexPath.section == 0 {
             let photosViewController = PhotosViewController()
             navigationController?.pushViewController(photosViewController, animated: true)
         }
     }
  }
