//
//  GitRepoModel.swift
//  GitHubber
//
//  Created by Cristian Murariu on 17/04/2019.
//  Copyright © 2019 Cristi. All rights reserved.
//

import UIKit

// We use the following 3 structs to build objects out of the json data
struct Owner: Decodable {
    let avatar_url: String
}
struct Item: Decodable {
    let owner: Owner
    let starsCount: Int
    let repoName: String
    
    enum CodingKeys: String, CodingKey {
        case owner
        case starsCount = "stargazers_count"
        case repoName = "full_name"
    }
}
// This is the model we'll use for the view model
public struct GitRepo: Decodable {
    var items: [Item]
}

