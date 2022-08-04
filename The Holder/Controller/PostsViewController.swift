//
//  ViewController.swift
//  The Holder
//
//  Created by Bagas Ilham on 01/08/22.
//

import UIKit

final class PostsViewController: UITableViewController {
    
    var displayedPosts: [PHPostResponse] = []
    var users: [PHUserResponse] = []
    var api = PlaceholderAPI.shared
    var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        setupLoadingIndicator()
        loadPosts()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let post = displayedPosts[row]
        let user = users[row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PostTableViewCell.self)", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        cell.fill(with: post)
        cell.fill(with: user)
        cell.onUserNameLabelTap = { [weak self] in
            guard let self = self else { return }
            self.goToUserDetail(user)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let post = displayedPosts[row]
        let user = users[row]
        let viewController = PostDetailViewController(post: post, user: user, style: .plain)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Posts"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "\(PostTableViewCell.self)")
    }
    
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ])
    }
    
    private func loadPosts() {
        loadingIndicator.startAnimating()
        api.getPosts { [weak self] result, error in
            guard let self = self, let result = result else {
                self?.handleLoadError()
                return
            }
            self.displayedPosts = result
            self.loadUsers(posts: result)
        }
    }
    
    private func loadUsers(posts: [PHPostResponse]) {
        let group = DispatchGroup()
        defer {
            group.notify(queue: .main) { [weak self] in
                guard let self = self else { return }
                self.loadingIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
        for post in posts {
            group.enter()
            api.getUserById(post.userID) { [weak self] result, error in
                guard let self = self, let result = result else {
                    self?.handleLoadError()
                    return
                }
                self.users.append(result)
                group.leave()
            }
        }
    }
    
    private func handleLoadError() {
        let alert = UIAlertController(
            title: "Error",
            message: "An error occured when fetching data.",
            preferredStyle: .alert
        )
        let retry = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.loadPosts()
        }
        alert.addAction(retry)
        self.present(alert, animated: true)
    }
    
    private func goToUserDetail(_ user: PHUserResponse) {
        let viewController = UserDetailViewController(user: user, style: .plain)
        navigationController?.pushViewController(viewController, animated: true)
    }

}
