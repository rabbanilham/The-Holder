//
//  HomeTableViewCell.swift
//  The Holder
//
//  Created by Bagas Ilham on 01/08/22.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    var backgroundColors: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemMint, .systemBlue, .systemCyan, .systemTeal, .systemPink, .systemIndigo, .systemPurple]
    
    var userInitialView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        return view
    }()
    
    var userInitialLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .systemBackground
        return label
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var userCompanyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    var postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    var postBodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    var onUserNameLabelTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defineLayout()
        setupNameTapRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        contentView.addSubviews(userInitialView, userNameLabel, userCompanyLabel, postTitleLabel, postBodyLabel)
        userInitialView.addSubview(userInitialLabel)
        let margin = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            userInitialView.topAnchor.constraint(equalTo: margin.topAnchor),
            userInitialView.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            userInitialView.heightAnchor.constraint(equalToConstant: 48),
            userInitialView.widthAnchor.constraint(equalTo: userInitialView.heightAnchor),
            
            userInitialLabel.centerXAnchor.constraint(equalTo: userInitialView.centerXAnchor),
            userInitialLabel.centerYAnchor.constraint(equalTo: userInitialView.centerYAnchor),
            
            userNameLabel.bottomAnchor.constraint(equalTo: userInitialView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: userInitialView.trailingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            userCompanyLabel.topAnchor.constraint(equalTo: userInitialView.centerYAnchor, constant: 2),
            userCompanyLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            userCompanyLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            
            postTitleLabel.topAnchor.constraint(equalTo: userInitialView.bottomAnchor, constant: 4),
            postTitleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            postTitleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            postBodyLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 4),
            postBodyLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            postBodyLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            postBodyLabel.bottomAnchor.constraint(equalTo: margin.bottomAnchor)
        ])
    }
    
    func fill(with post: PHPostResponse) {
        postTitleLabel.text = post.title
        postBodyLabel.text = post.body
    }
    
    func fill(with user: PHUserResponse) {
        userInitialView.backgroundColor = backgroundColors.randomElement()
        let initial = String(user.name.prefix(1))
        userInitialLabel.text = initial
        userNameLabel.text = user.name
        userCompanyLabel.text = user.company.name
    }
    
    private func setupNameTapRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapUserNameLabel))
        userNameLabel.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func didTapUserNameLabel() {
        onUserNameLabelTap?()
    }
    
}
