//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 15.03.2026.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private var photos: [UIImage] = (1...20).compactMap{UIImage(named: "photo\($0)")}
    private let imageProcessor = ImageProcessor()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Photo Gallery"
        setupCollectionView()
        setupConstraints()
        processPhotos(qos: .userInteractive, filter: .noir) { [weak self] in self?.processPhotos(qos: .background, filter: .noir)}
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
     }

     private func setupConstraints() {
         let safeAreaGuide = view.safeAreaLayoutGuide
         NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
         ])
     }
    
    private func processPhotos(qos: QualityOfService, filter: ColorFilter, completion: (() -> Void)? = nil) {
        let startTime = Date()
        imageProcessor.processImagesOnThread(sourceImages: photos, filter: filter, qos: qos){ cqImages in
            let elapsedTime = Date().timeIntervalSince(startTime)
            print("qos: \(qos), filter: \(filter), elapsed time: \(elapsedTime) сек")
            let processedImages = cqImages.compactMap { $0 }.map {UIImage(cgImage: $0)}
            
            DispatchQueue.main.async {
                self.photos = processedImages
                self.collectionView.reloadData()
                completion?()
            }
        }
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell { guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotosCollectionViewCell else {
        fatalError("could not dequeueReusableCell")
    }
    cell.update(photos[indexPath.row])
    return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = 2 * LayoutConstant.spacing + 2 * LayoutConstant.spacing
        let width = (view.frame.width - totalSpacing) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        LayoutConstant.spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        LayoutConstant.spacing
    }
  }




