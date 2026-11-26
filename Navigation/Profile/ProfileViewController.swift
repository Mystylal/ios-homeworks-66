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
    weak var coordinator: ProfileCoordinator?
    
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
        title = NSLocalizedString("profile.title", comment: "")
        #if DEBUG
        view.backgroundColor = .appBackground
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
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
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
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        guard let index = gesture.view?.tag, index < posts.count else { return }
        CoreDataService.shared.savePost(posts[index])
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
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        cell.contentView.tag = indexPath.row
        cell.contentView.addGestureRecognizer(doubleTap)
        cell.contentView.isUserInteractionEnabled = true
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
             coordinator?.showPhotos()
         }
     }
  }

extension ProfileViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard indexPath.section == 1 else { return [] }
        let post = posts[indexPath.row]
        let imageProvider = NSItemProvider(object: post.image)
        let textProvider = NSItemProvider(object: post.description as NSString)
        return [UIDragItem(itemProvider: imageProvider), UIDragItem(itemProvider: textProvider)]
    }
}

extension ProfileViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, canHandle session: UIDragSession) -> Bool {
        guard case .loaded = viewModel.state else { return false }
        return session.canLoadObjects(ofClass: NSString.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if destinationIndexPath?.section == 0 {
            return UITableViewDropProposal(operation: .forbidden)
        }
        return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        guard destinationIndexPath.section == 1 else { return }
        
        var image: UIImage?
        var text: String?
        
        let insertPostIfReady = { [weak self] in
            guard let self, let image, let text else { return }
            
            let post = Post(author: "Drag&Drop", description: text, image: image, likes: 0, views: 0)
            
            let row = min(self.posts.count, destinationIndexPath.row)
            let indexPath = IndexPath(row: row, section: destinationIndexPath.section)
            
            PostStorage.posts.insert(post, at: row)
            self.posts.insert(post, at: row)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        coordinator.session.loadObjects(ofClass: UIImage.self) { items in
            image = items.first as? UIImage
            insertPostIfReady()
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            text = (items.first as? NSString).map { $0 as String}
            insertPostIfReady()
        }
    }
}
