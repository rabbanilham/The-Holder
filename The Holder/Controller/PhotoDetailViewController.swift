//
//  PhotoDetailViewController.swift
//  The Holder
//
//  Created by Bagas Ilham on 04/08/22.
//

import UIKit

final class PhotoDetailViewController: UIViewController {
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var photoNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var minimumSize: CGFloat = UIScreen.main.bounds.width - 64
    
    init(photo: PHPhotoResponse) {
        photoNameLabel.text = photo.title
        if let url = URL(string: photo.url) {
            photoImageView.kf.indicatorType = .activity
            photoImageView.kf.setImage(with: url, options: [.cacheOriginalImage, .transition(.fade(0.25))])
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNameLabel()
        setupPhotoImageView()
        navigationItem.title = "Photo Detail"
    }
    
    private func setupNameLabel() {
        view.addSubview(photoNameLabel)
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            photoNameLabel.topAnchor.constraint(equalTo: margin.topAnchor, constant: 36),
            photoNameLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            photoNameLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor)
        ])
    }
    
    private func setupPhotoImageView() {
        view.addSubview(photoImageView)
        view.backgroundColor = .systemBackground
        photoImageView.frame = CGRect(x: 0, y: 0, width: minimumSize, height: minimumSize)
        photoImageView.center = view.center
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        photoImageView.addGestureRecognizer(pinchRecognizer)
    }
    
    @objc private func didPinch(_ gesture: UIPinchGestureRecognizer) {
        let scale = gesture.scale
        if gesture.state == .changed, photoImageView.frame.height >= minimumSize {
            photoImageView.frame = CGRect(
                x: 0,
                y: 0,
                width: minimumSize * scale,
                height: minimumSize * scale
            )
            photoImageView.center = view.center
        } else if gesture.state == .changed, photoImageView.frame.height < minimumSize {
            if scale >= 1 {
                photoImageView.frame = CGRect(
                    x: 0,
                    y: 0,
                    width: minimumSize * scale,
                    height: minimumSize * scale
                )
                photoImageView.center = view.center
            }
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCurlDown) { [weak self] in
                guard let self = self else { return }
                self.photoImageView.frame = CGRect(
                    x: 0,
                    y: 0,
                    width: self.minimumSize,
                    height: self.minimumSize
                )
                self.photoImageView.center = self.view.center
            }

        }
    }
    
}
