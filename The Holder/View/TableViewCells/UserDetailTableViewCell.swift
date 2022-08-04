//
//  UserDetailTableViewCell.swift
//  The Holder
//
//  Created by Bagas Ilham on 02/08/22.
//

import UIKit

final class UserDetailTableViewCell: UITableViewCell {
    
    var backgroundColors: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemMint, .systemBlue, .systemCyan, .systemTeal, .systemPink, .systemIndigo, .systemPurple]
    
    var userInitialView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 48
        return view
    }()
    
    var userInitialLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .systemBackground
        return label
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var userCompanyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var userEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    var userAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defineLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        contentView.addSubviews(userInitialView, userNameLabel, userEmailLabel, userCompanyLabel, userAddressLabel)
        userInitialView.addSubview(userInitialLabel)
        
        let margin = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10),
            
            userInitialView.topAnchor.constraint(equalTo: margin.topAnchor),
            userInitialView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userInitialView.heightAnchor.constraint(equalToConstant: 96),
            userInitialView.widthAnchor.constraint(equalTo: userInitialView.heightAnchor),
            
            userInitialLabel.centerXAnchor.constraint(equalTo: userInitialView.centerXAnchor),
            userInitialLabel.centerYAnchor.constraint(equalTo: userInitialView.centerYAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: userInitialView.bottomAnchor, constant: 12),
            userNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4),
            userEmailLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            userCompanyLabel.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 4),
            userCompanyLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            userAddressLabel.topAnchor.constraint(equalTo: userCompanyLabel.bottomAnchor, constant: 4),
            userAddressLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userAddressLabel.bottomAnchor.constraint(equalTo: margin.bottomAnchor)
        ])
    }
    
    func fill(with user: PHUserResponse) {
        userInitialView.backgroundColor = backgroundColors.randomElement()
        let initial = String(user.name.prefix(1))
        userInitialLabel.text = initial
        userNameLabel.text = user.name
        userEmailLabel.text = user.email
        userCompanyLabel.text = user.company.name
        userAddressLabel.text = "\(user.address.suite), \(user.address.street), \(user.address.city), \(user.address.zipcode)\n\(user.address.geo.lat), \(user.address.geo.lng)"
    }
    
}
