//
//  UserDetailViewController.swift
//  The Holder
//
//  Created by Bagas Ilham on 02/08/22.
//

import UIKit
import Kingfisher

final class UserDetailViewController: UITableViewController {
    
    var user: PHUserResponse
    var albums: [PHAlbumResponse] = []
    var photos: [[PHPhotoResponse]] = []
    var api = PlaceholderAPI.shared
    
    init(user: PHUserResponse, style: UITableView.Style) {
        self.user = user
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Kingfisher.KingfisherManager.shared.cache.clearCache()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadUserAlbums()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return albums.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Albums"
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserDetailTableViewCell.self)", for: indexPath) as? UserDetailTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.fill(with: user)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(AlbumTableViewCell.self)", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
            let row = indexPath.row
            let album = albums[row]
            cell.albumNameLabel.text = album.title
            cell.photos = photos[row]
            cell.didSelectCollectionCell = { [weak self] photo in
                guard let self = self else { return }
                let viewController = PhotoDetailViewController(photo: photo)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    private func setupTableView() {
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: "\(UserDetailTableViewCell.self)")
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "\(AlbumTableViewCell.self)")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        navigationItem.title = "User Detail"
    }
    
    private func loadUserAlbums() {
        api.getAlbums(userId: user.id) { [weak self] result, error in
            guard let self = self, let result = result else {
                return
            }
            self.albums = result
            self.loadAlbumPhotos(result)
        }
    }
    
    private func loadAlbumPhotos(_ albums: [PHAlbumResponse]) {
        let group = DispatchGroup()
        defer {
            group.notify(queue: .main) { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
        for album in albums {
            group.enter()
            api.getAlbumPhotos(albumId: album.id) { [weak self] result, error in
                guard let self = self, let result = result else {
                    return
                }
                self.photos.append(result)
                group.leave()
            }
        }
    }
    
}

