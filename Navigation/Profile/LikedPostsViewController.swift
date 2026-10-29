//
//  LikedPostsViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 30.09.2026.
//

import UIKit
import StorageService

class LikedPostsViewController: UIViewController {
    private var posts: [Post] = []
    private var cdPosts: [CDPost] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Понравившиеся"
        view.backgroundColor = .white
        setupTableView()
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: self, action: #selector(clearFilterTap)),
            UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(filterTap))
        ]
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadLikedPosts()
    }
    
    private func loadLikedPosts() {
        cdPosts = CoreDataService.shared.fetchPosts()
        tableView.reloadData()
    }
    
    @objc private func clearFilterTap() {
        loadLikedPosts()
    }
    
    private func applyFilter(author: String) {
        cdPosts = CoreDataService.shared.fetchPosts(author: author)
        tableView.reloadData()
    }
    
    @objc private func filterTap() {
        let alert = UIAlertController(title: "Фильтр по автору", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Имя автора"
        }
        let applyAction = UIAlertAction(title: "Применить", style: .default) { [weak self, weak alert] _ in
            guard let author = alert?.textFields?.first?.text, !author.isEmpty else { return }
            self?.applyFilter(author: author)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(applyAction)
        alert.addAction(cancelAction)
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

extension LikedPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cdPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            fatalError("Could not dequeue cell")
        }
        let cdPost = cdPosts[indexPath.row]
        let post = Post(
            author: cdPost.author ?? "",
            description: cdPost.postDescription ?? "",
            image: cdPost.image ?? "",
            likes: Int(cdPost.likes),
            views: Int(cdPost.views)
        )
        cell.update(post)
        return cell
    }
}

extension LikedPostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _,_, complection in
            guard let self else { return }
            let cdPost = self.cdPosts[indexPath.row]
            CoreDataService.shared.deletePost(cdPost)
            self.cdPosts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            complection(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
