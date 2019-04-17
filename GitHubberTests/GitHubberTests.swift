//
//  GitHubberTests.swift
//  GitHubberTests
//
//  Created by Cristi on 15/04/2019.
//  Copyright © 2019 Cristi. All rights reserved.
//

import XCTest
@testable import GitHubber

class GitHubberTests: XCTestCase {
    
    let loginViewModel: LoginViewModel = LoginViewModel()
    let homeViewModel: HomeViewModel = HomeViewModel()

    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginVM() {
        XCTAssertFalse(loginViewModel.validateLogin(userEmail: nil, userPassword: nil), "we should pass in an username and password")
        XCTAssertFalse(loginViewModel.validateLogin(userEmail: "test", userPassword: nil), "we should pass in a password")
        XCTAssertFalse(loginViewModel.validateLogin(userEmail: "test", userPassword: "test"), "this is not a valid email")
        XCTAssertFalse(loginViewModel.validateLogin(userEmail: "test@test.", userPassword: "test"), "this is not a valid email either")
        XCTAssertFalse(loginViewModel.validateLogin(userEmail: nil, userPassword: "password"), "we should pass in an email")
        XCTAssertFalse(loginViewModel.validateLogin(userEmail: "test@test.com", userPassword: "12345"), "we made a convention that the passwork should have at least 6 characters")
        XCTAssertTrue(loginViewModel.validateLogin(userEmail: "test@test.com", userPassword: "123456"), "now we should be ok")
    }
    
    func testHomeVM() {
        // For the home view model, we can pass in arbitrary data, valid and invalid, and see how the repository property will behave
        let validDataWith2Entries = GitHubberTests.testGithubJson.data(using: .utf8)
        homeViewModel.buildRepositoryObject(from: validDataWith2Entries!)
        XCTAssertEqual(homeViewModel.repository.items.count, 2, "we should have two items stored in the repository")
        homeViewModel.sortAndRefresh(.stars)
        XCTAssertGreaterThan(homeViewModel.repository.items[0].starsCount, homeViewModel.repository.items[1].starsCount, "the first item in the array should be the one with the most stars")
        XCTAssertEqual(homeViewModel.repository.items[0].repoName, "Moya/Moya", "Moya should be the first element")
        let emptyData = "".data(using: .utf8)
        homeViewModel.buildRepositoryObject(from: emptyData!)
        XCTAssertEqual(homeViewModel.repository.items.count, 2, "An empty data / invalid data case should be catched and the model shouldn't be modified")
    }

    static var testGithubJson: String {
        return """
        {
        "total_count": 2946,
        "incomplete_results": false,
        "items": [
        {
        "id": 33569135,
        "node_id": "MDEwOlJlcG9zaXRvcnkzMzU2OTEzNQ==",
        "name": "RxSwift",
        "full_name": "ReactiveX/RxSwift",
        "private": false,
        "owner": {
        "login": "ReactiveX",
        "id": 6407041,
        "node_id": "MDEyOk9yZ2FuaXphdGlvbjY0MDcwNDE=",
        "avatar_url": "https://avatars1.githubusercontent.com/u/6407041?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/ReactiveX",
        "html_url": "https://github.com/ReactiveX",
        "followers_url": "https://api.github.com/users/ReactiveX/followers",
        "following_url": "https://api.github.com/users/ReactiveX/following{/other_user}",
        "gists_url": "https://api.github.com/users/ReactiveX/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/ReactiveX/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/ReactiveX/subscriptions",
        "organizations_url": "https://api.github.com/users/ReactiveX/orgs",
        "repos_url": "https://api.github.com/users/ReactiveX/repos",
        "events_url": "https://api.github.com/users/ReactiveX/events{/privacy}",
        "received_events_url": "https://api.github.com/users/ReactiveX/received_events",
        "type": "Organization",
        "site_admin": false
        },
        "html_url": "https://github.com/ReactiveX/RxSwift",
        "description": "Reactive Programming in Swift",
        "fork": false,
        "url": "https://api.github.com/repos/ReactiveX/RxSwift",
        "forks_url": "https://api.github.com/repos/ReactiveX/RxSwift/forks",
        "keys_url": "https://api.github.com/repos/ReactiveX/RxSwift/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/ReactiveX/RxSwift/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/ReactiveX/RxSwift/teams",
        "hooks_url": "https://api.github.com/repos/ReactiveX/RxSwift/hooks",
        "issue_events_url": "https://api.github.com/repos/ReactiveX/RxSwift/issues/events{/number}",
        "events_url": "https://api.github.com/repos/ReactiveX/RxSwift/events",
        "assignees_url": "https://api.github.com/repos/ReactiveX/RxSwift/assignees{/user}",
        "branches_url": "https://api.github.com/repos/ReactiveX/RxSwift/branches{/branch}",
        "tags_url": "https://api.github.com/repos/ReactiveX/RxSwift/tags",
        "blobs_url": "https://api.github.com/repos/ReactiveX/RxSwift/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/ReactiveX/RxSwift/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/ReactiveX/RxSwift/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/ReactiveX/RxSwift/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/ReactiveX/RxSwift/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/ReactiveX/RxSwift/languages",
        "stargazers_url": "https://api.github.com/repos/ReactiveX/RxSwift/stargazers",
        "contributors_url": "https://api.github.com/repos/ReactiveX/RxSwift/contributors",
        "subscribers_url": "https://api.github.com/repos/ReactiveX/RxSwift/subscribers",
        "subscription_url": "https://api.github.com/repos/ReactiveX/RxSwift/subscription",
        "commits_url": "https://api.github.com/repos/ReactiveX/RxSwift/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/ReactiveX/RxSwift/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/ReactiveX/RxSwift/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/ReactiveX/RxSwift/issues/comments{/number}",
        "contents_url": "https://api.github.com/repos/ReactiveX/RxSwift/contents/{+path}",
        "compare_url": "https://api.github.com/repos/ReactiveX/RxSwift/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/ReactiveX/RxSwift/merges",
        "archive_url": "https://api.github.com/repos/ReactiveX/RxSwift/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/ReactiveX/RxSwift/downloads",
        "issues_url": "https://api.github.com/repos/ReactiveX/RxSwift/issues{/number}",
        "pulls_url": "https://api.github.com/repos/ReactiveX/RxSwift/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/ReactiveX/RxSwift/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/ReactiveX/RxSwift/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/ReactiveX/RxSwift/labels{/name}",
        "releases_url": "https://api.github.com/repos/ReactiveX/RxSwift/releases{/id}",
        "deployments_url": "https://api.github.com/repos/ReactiveX/RxSwift/deployments",
        "created_at": "2015-04-07T21:25:17Z",
        "updated_at": "2019-04-16T10:21:15Z",
        "pushed_at": "2019-04-16T17:29:42Z",
        "git_url": "git://github.com/ReactiveX/RxSwift.git",
        "ssh_url": "git@github.com:ReactiveX/RxSwift.git",
        "clone_url": "https://github.com/ReactiveX/RxSwift.git",
        "svn_url": "https://github.com/ReactiveX/RxSwift",
        "homepage": "",
        "size": 13629,
        "stargazers_count": 123,
        "watchers_count": 16072,
        "language": "Swift",
        "has_issues": true,
        "has_projects": true,
        "has_downloads": true,
        "has_wiki": true,
        "has_pages": false,
        "forks_count": 2652,
        "mirror_url": null,
        "archived": false,
        "disabled": false,
        "open_issues_count": 25,
        "license": {
        "key": "other",
        "name": "Other",
        "spdx_id": "NOASSERTION",
        "url": null,
        "node_id": "MDc6TGljZW5zZTA="
        },
        "forks": 2652,
        "open_issues": 25,
        "watchers": 16072,
        "default_branch": "master",
        "score": 170.51863
        },
        {
        "id": 23013268,
        "node_id": "MDEwOlJlcG9zaXRvcnkyMzAxMzI2OA==",
        "name": "Moya",
        "full_name": "Moya/Moya",
        "private": false,
        "owner": {
        "login": "Moya",
        "id": 13662162,
        "node_id": "MDEyOk9yZ2FuaXphdGlvbjEzNjYyMTYy",
        "avatar_url": "https://avatars3.githubusercontent.com/u/13662162?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/Moya",
        "html_url": "https://github.com/Moya",
        "followers_url": "https://api.github.com/users/Moya/followers",
        "following_url": "https://api.github.com/users/Moya/following{/other_user}",
        "gists_url": "https://api.github.com/users/Moya/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/Moya/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/Moya/subscriptions",
        "organizations_url": "https://api.github.com/users/Moya/orgs",
        "repos_url": "https://api.github.com/users/Moya/repos",
        "events_url": "https://api.github.com/users/Moya/events{/privacy}",
        "received_events_url": "https://api.github.com/users/Moya/received_events",
        "type": "Organization",
        "site_admin": false
        },
        "html_url": "https://github.com/Moya/Moya",
        "description": "Network abstraction layer written in Swift.",
        "fork": false,
        "url": "https://api.github.com/repos/Moya/Moya",
        "forks_url": "https://api.github.com/repos/Moya/Moya/forks",
        "keys_url": "https://api.github.com/repos/Moya/Moya/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/Moya/Moya/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/Moya/Moya/teams",
        "hooks_url": "https://api.github.com/repos/Moya/Moya/hooks",
        "issue_events_url": "https://api.github.com/repos/Moya/Moya/issues/events{/number}",
        "events_url": "https://api.github.com/repos/Moya/Moya/events",
        "assignees_url": "https://api.github.com/repos/Moya/Moya/assignees{/user}",
        "branches_url": "https://api.github.com/repos/Moya/Moya/branches{/branch}",
        "tags_url": "https://api.github.com/repos/Moya/Moya/tags",
        "blobs_url": "https://api.github.com/repos/Moya/Moya/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/Moya/Moya/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/Moya/Moya/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/Moya/Moya/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/Moya/Moya/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/Moya/Moya/languages",
        "stargazers_url": "https://api.github.com/repos/Moya/Moya/stargazers",
        "contributors_url": "https://api.github.com/repos/Moya/Moya/contributors",
        "subscribers_url": "https://api.github.com/repos/Moya/Moya/subscribers",
        "subscription_url": "https://api.github.com/repos/Moya/Moya/subscription",
        "commits_url": "https://api.github.com/repos/Moya/Moya/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/Moya/Moya/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/Moya/Moya/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/Moya/Moya/issues/comments{/number}",
        "contents_url": "https://api.github.com/repos/Moya/Moya/contents/{+path}",
        "compare_url": "https://api.github.com/repos/Moya/Moya/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/Moya/Moya/merges",
        "archive_url": "https://api.github.com/repos/Moya/Moya/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/Moya/Moya/downloads",
        "issues_url": "https://api.github.com/repos/Moya/Moya/issues{/number}",
        "pulls_url": "https://api.github.com/repos/Moya/Moya/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/Moya/Moya/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/Moya/Moya/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/Moya/Moya/labels{/name}",
        "releases_url": "https://api.github.com/repos/Moya/Moya/releases{/id}",
        "deployments_url": "https://api.github.com/repos/Moya/Moya/deployments",
        "created_at": "2014-08-16T07:41:21Z",
        "updated_at": "2019-04-16T18:13:35Z",
        "pushed_at": "2019-04-15T14:26:33Z",
        "git_url": "git://github.com/Moya/Moya.git",
        "ssh_url": "git@github.com:Moya/Moya.git",
        "clone_url": "https://github.com/Moya/Moya.git",
        "svn_url": "https://github.com/Moya/Moya",
        "homepage": "https://moya.github.io",
        "size": 17016,
        "stargazers_count": 124,
        "watchers_count": 10527,
        "language": "Swift",
        "has_issues": true,
        "has_projects": true,
        "has_downloads": true,
        "has_wiki": false,
        "has_pages": false,
        "forks_count": 1235,
        "mirror_url": null,
        "archived": false,
        "disabled": false,
        "open_issues_count": 39,
        "license": {
        "key": "mit",
        "name": "MIT License",
        "spdx_id": "MIT",
        "url": "https://api.github.com/licenses/mit",
        "node_id": "MDc6TGljZW5zZTEz"
        },
        "forks": 1235,
        "open_issues": 39,
        "watchers": 10527,
        "default_branch": "master",
        "score": 83.14829
        }
        ]
        }
"""
    }

}
