//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 10.03.2026.
//

import UIKit

class ProfileViewController: UIViewController {
    private let posts: [Post] = [
        Post(author: "Intel", description: "Intel показал НОВЫЕ процессоры Core Ultra 7 270K Plus и 250K Plus — «самые быстрые игровые процессоры в мире».", image: "intel", likes: 245, views: 1200),
                                  
        Post(author: "Песков", description: "«Думайте о MAX, а не о Telegram», — посоветовал Песков.", image: "peskov", likes: 566, views:
       3400),
        
        Post(author: "Ferrari", description: "Ferrari показала открытую версию своей самой доступной модели — Amalfi Spider.", image: "ferrari", likes: 890, views: 5600),
        
        Post(author: "Resident Evil", description: "Resident Evil Requiem получит сюжетное DLC — официально.", image: "resident", likes:
       312, views: 2100) ]
   
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
        tuneTableView()
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
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
          posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
              fatalError("could not dequeueReusableCell")
    }
    cell.update(posts[indexPath.row])
    return cell
    }
}
                                                               
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ProfileHeaderView()
        headerView.setupViews()
        return headerView
    }
                                                                     
    func tableView(_ tableView: UITableView,heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
  }
