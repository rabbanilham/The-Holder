//
//  AlbumTableViewCell.swift
//  The Holder
//
//  Created by Bagas Ilham on 03/08/22.
//

import UIKit

final class AlbumTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var photos: [PHPhotoResponse]!
    
    var albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    var albumCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: "\(AlbumCollectionViewCell.self)")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(UICollectionViewCell.self)")
        return collectionView
    }()
    
    var didSelectCollectionCell: ((PHPhotoResponse) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defineLayout()
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        albumCollectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: "\(AlbumCollectionViewCell.self)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        contentView.addSubviews(albumCollectionView, albumNameLabel)
        
        let margin = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10),
            
            albumNameLabel.topAnchor.constraint(equalTo: margin.topAnchor),
            albumNameLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            albumNameLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            albumCollectionView.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 4),
            albumCollectionView.bottomAnchor.constraint(equalTo: margin.bottomAnchor),
            albumCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            albumCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AlbumCollectionViewCell.self)", for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }
        let item = indexPath.item
        let photo = photos[item]
        cell.fill(with: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        let photo = photos[item]
        didSelectCollectionCell?(photo)
    }
    
}
