//
//  HomeViewController.swift
//  GitHubber
//
//  Created by Cristi on 15/04/2019.
//  Copyright © 2019 Cristi. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UITableViewController {
    
    @IBAction func sortControlAction(_ sender: Any) {
        if let segmentedControl = sender as? UISegmentedControl {
            presenter.sortAndRefresh(segmentedControl.selectedSegmentIndex == 0 ? .stars : .alphabetically)
        }
    }
    
    var presenter = HomePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewController = self
    }
}

// Data source
extension HomeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repository.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitCell", for: indexPath)
        cell.textLabel?.text = presenter.repository.items[indexPath.row].repoName
        cell.imageView?.sd_setImage(with: URL(string: presenter.repository.items[indexPath.row].owner.avatar_url), placeholderImage: UIImage(named: "placeholderImg"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // this is added here to prevent displaying empty rows
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
