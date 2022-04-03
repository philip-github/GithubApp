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
        let nib = UINib(nibName: CustomXIBTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CustomXIBTableViewCell.identifier)
        return tableView
    }()
    
    var userCommits: [[UserCommits]]? = []
    var pageNumber = 3
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
        Loader.shared.showLoading(viewController: self)
        Task.init(priority: .background) {
            do{
                let userCommitstask = try await GHViewModel.shared.loadUserRepos(url: "\(NetworkURL.Users.rawValue)\(EndPoints.per_page.rawValue)\(numberOfPages)")
                self.userCommits?.append(userCommitstask)
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                    Loader.shared.stopLoading()
                }
            }catch{
                Loader.shared.stopLoading()
                ErrorPresenter.showError(viewController: self)
            }
        }
    }
}


//MARK: Table View //
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCommits?.reduce([], +).count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomXIBTableViewCell.identifier) as? CustomXIBTableViewCell else { return CustomXIBTableViewCell() }
        let flatData = userCommits?.reduce([], +)
        guard let data = flatData?[indexPath.row] else { return CustomXIBTableViewCell() }
        cell.authorLabel.text = "Author: \(String(describing: data.commit?.author.name ?? "No Author"))"
        cell.messageLabel.text = "Message: \(String(describing: data.commit?.message ?? "No Message"))"
        cell.shaLabel.text = "SHA: \(String(describing: data.commit?.tree.sha ?? "No SHA"))"
        return cell
    }
}
