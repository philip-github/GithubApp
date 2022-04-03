//
//  ViewController.swift
//  GitHubApp
//
//  Created by Philip Twal on 3/29/22.
//

import UIKit

class ViewController: UIViewController {

    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    var userCommits: [[UserCommits]]? = []
    var pageNumber = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadRepos(numberOfPages: pageNumber)
    }
    
    override func viewDidLayoutSubviews() {
        setupNavigationBar()
        setupTableView()
    }
    
    func setupTableView(){
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    func setupNavigationBar(){
        view.backgroundColor = .darkGray
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "GitHub"
    }
    
    func loadRepos(numberOfPages: Int){
        Task.init(priority: .background) {
            let userCommitstask = try await GHViewModel.shared.loadUserRepos(url: "\(NetworkURL.Users.rawValue)\(EndPoints.per_page.rawValue)\(numberOfPages)")
            self.userCommits?.append(userCommitstask)
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}


//MARK: Table View //
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCommits?.reduce([], +).count ?? 0
    }
    
    func  numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = transform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as? CustomTableViewCell else { return CustomTableViewCell() }
        let flatData = userCommits?.reduce([], +)
        guard let data = flatData?[indexPath.row] else { return CustomTableViewCell() }
        cell.authorLabel.text = "Author: \(String(describing: data.commit?.author.name ?? "No Author"))"
        cell.messageLabel.text = "Message: \(String(describing: data.commit?.message ?? "No Message"))"
        cell.shaLabel.text = "SHA: \(String(describing: data.commit?.tree.sha ?? "No SHA"))"
        return cell
    }
}
