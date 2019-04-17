//
//  HomeViewModel.swift
//  GitHubber
//
//  Created by Cristi on 16/04/2019.
//  Copyright © 2019 Cristi. All rights reserved.
//

import UIKit

// Define a result to work with for the network library, which is available in Swift5
enum Result<Value> {
    case success(Value)
    case failure(Error)
}

// This would tell the view model which sorting option to use
enum RepositorySorting {
    case stars
    case alphabetically
}

class HomeViewModel {
    // the datasource for this view model
    var repository: GitRepo = GitRepo(items: [])
    // define the initial sort state
    var sorting: RepositorySorting = .stars
    private let networkClient = HomeNetworkClient()
    // define hom many repositories to request per page from the Github API
    private let numberOfReposToFetch = 10
    
    // set the VC for this view model
    weak var viewController: HomeViewController? {
        didSet {
            // when the vc is set, fetch the repositories for it
            fetchRepos()
        }
    }
    
    // this method would get called by the vc on a segmented control change
    func sortAndRefresh(_ sortBy: RepositorySorting) {
        sorting = sortBy
        let sorted = repository.items.sorted { item1, item2 in
            sorting == .stars ? item1.starsCount > item2.starsCount : item1.repoName < item2.repoName
        }
        repository.items = sorted
        
        viewController?.tableView.reloadData()
    }
    
    private func fetchRepos() {
        let repo = Repo.getRepositories(numberOfRepositories: 10)        
        networkClient.request(for: repo) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    self?.buildRepositoryObject(from: jsonData)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func buildRepositoryObject(from jsonData: Data) {
        do {
            let decoder = JSONDecoder()
            let repo = try decoder.decode(GitRepo.self, from: jsonData)
            updateRepositories(repo: repo)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func updateRepositories(repo: GitRepo) {
        repository = repo
        sortAndRefresh(sorting)
    }
}
