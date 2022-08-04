//
//  AlbumCollectionViewCell.swift
//  The Holder
//
//  Created by Bagas Ilham on 03/08/22.
//

import UIKit
import Kingfisher

final class AlbumCollectionViewCell: UICollectionViewCell {
    
    private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defineLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor)
        ])
    }
    
    func fill(with photo: PHPhotoResponse) {
        if let url = URL(string: photo.thumbnailURL) {
            photoImageView.kf.indicatorType = .activity
            photoImageView.kf.setImage(with: url, options: [.cacheOriginalImage, .transition(.fade(0.25))])
        } else {
            photoImageView.contentMode = .scaleAspectFit
            photoImageView.image = UIImage(systemName: "photo.fill")
        }
    }
    
}
