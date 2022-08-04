//
//  PostDetailViewController.swift
//  The Holder
//
//  Created by Bagas Ilham on 02/08/22.
//

import UIKit

final class PostDetailViewController: UITableViewController {
    var post: PHPostResponse
    var user: PHUserResponse
    var api = PlaceholderAPI.shared
    var comments: [PHCommentResponse] = []
    
    init(post: PHPostResponse, user: PHUserResponse, style: UITableView.Style) {
        self.post = post
        self.user = user
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadComments()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Comments"
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return comments.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PostTableViewCell.self)", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.fill(with: post)
            cell.fill(with: user)
            cell.onUserNameLabelTap = { [weak self] in
                guard let self = self else { return }
                self.goToUserDetail()
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            let row = indexPath.row
            let comment = comments[row]
            var config = cell.defaultContentConfiguration()
            config.text = comment.name
            config.secondaryText = comment.body
            cell.contentConfiguration = config
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "\(PostTableViewCell.self)")
        navigationItem.title = "Post Detail"
    }
    
    private func loadComments() {
        api.getComments(post.id) { [weak self] result, error in
            guard let self = self, let result = result else {
                if let self = self {
                    self.presentFailAlert()
                }
                return
            }
            self.comments = result
            self.tableView.reloadData()
        }
    }
    
    private func goToUserDetail() {
        let viewController = UserDetailViewController(user: user, style: .plain)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentFailAlert() {
        let alert = UIAlertController(
            title: "Error",
            message: "An error occured while loading comments. Try again?",
            preferredStyle: .alert
        )
        let later = UIAlertAction(
            title: "Later",
            style: .cancel
        )
        let retry = UIAlertAction(title: "Try Again", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.loadComments()
        }
        alert.addAction(later)
        alert.addAction(retry)
        self.present(alert, animated: true)
    }
    
}
